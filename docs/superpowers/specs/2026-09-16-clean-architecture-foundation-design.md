# Clean Architecture Foundation — Design Spec

**Data:** 2026-09-16
**Status:** Aguardando revisão do usuário
**Abordagem:** Foundation Completa (Abordagem A)

## Contexto

O projeto BarberFlow é um app Flutter de agendamento de barbearias com dois perfis (Cliente e Barbeiro). Partindo de um projeto virgem (`flutter create`), esta spec define a fundação arquitetural completa: estrutura de pastas, injeção de dependências, error handling, inicialização Firebase e segurança.

**Stack definida:** Flutter + Firebase + BLoC/Cubit + MVVM + Clean Architecture
**Decisões do brainstorming:**
- Organização: **Feature-first** (cada feature contém domain/data/presentation)
- DI: **get_it + injectable** (Service Locator com code-gen)
- Error handling: **fpdart** (Either funcional)

---

## 1. Estrutura de Pastas

```
lib/
├── main.dart                              # Entry point: DI, .env, Firebase, runApp
├── app.dart                               # MaterialApp com rotas e tema
│
├── core/                                  # Compartilhado entre features
│   ├── di/
│   │   ├── injection_container.dart       # GetIt + @InjectableInit
│   │   └── register_module.dart           # Módulo para dependências externas (Firebase, etc)
│   ├── error/
│   │   ├── failures.dart                  # Sealed class Failure (ServerFailure, AuthFailure, etc)
│   │   └── exceptions.dart                # Exceptions da camada Data
│   ├── network/
│   │   └── network_info.dart              # Abstração de conectividade (interface)
│   ├── usecases/
│   │   └── usecase.dart                   # Contrato base: UseCase<Type, Params>
│   ├── theme/
│   │   └── app_theme.dart                 # Cores, tipografia, tema global
│   ├── routes/
│   │   └── app_router.dart                # Navegação centralizada
│   ├── constants/
│   │   └── app_constants.dart             # Strings e constantes globais
│   └── utils/
│       └── typedefs.dart                  # FutureEither<T>, FutureVoid
│
├── features/
│   └── auth/                              # Feature template (primeira real)
│       ├── domain/
│       │   ├── entities/
│       │   │   └── user_entity.dart
│       │   ├── repositories/
│       │   │   └── auth_repository.dart   # Contrato abstrato
│       │   └── usecases/
│       │       └── sign_in_with_google.dart
│       ├── data/
│       │   ├── models/
│       │   │   └── user_model.dart        # Extends/implements entity
│       │   ├── repositories/
│       │   │   └── auth_repository_impl.dart
│       │   └── datasources/
│       │       └── auth_remote_datasource.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── auth_bloc.dart
│           │   └── auth_state.dart
│           ├── pages/
│           └── widgets/
```

**Princípios:**
- `core/` centraliza o que cruza features (DI, erros, rotas, tema)
- Cada feature tem o trio `domain/data/presentation` completo e isolado
- `domain/repositories/` é abstrato (contrato); `data/repositories/` é a implementação concreta
- BLoC vive em `presentation/bloc/` (padrão MVVM conforme skill 04)
- Limite de 150-200 linhas por widget/classe; componentizar se ultrapassar

---

## 2. Injeção de Dependências

### Configuração base (get_it + injectable)

```dart
// core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection_container.config.dart';

final sl = GetIt.instance;

@InjectableInit()
void configureDependencies() => sl.init();
```

### Lifecycle por camada

| Camada | Anotação | Lifecycle | Justificativa |
|---|---|---|---|
| DataSource | `@LazySingleton(as: Interface)` | Singleton lazy | Uma instância, criada sob demanda |
| Repository | `@LazySingleton(as: Interface)` | Singleton lazy | Uma instância, criada sob demanda |
| UseCase | `@LazySingleton` | Singleton lazy | Stateless, pode ser compartilhado |
| BLoC/Cubit | `@injectable` | Factory | Nova instância por tela, evita estado compartilhado |

### Módulo para dependências externas

```dart
// core/di/register_module.dart
@module
abstract class RegisterModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();
}
```

### Code-gen

Executar `dart run build_runner build --delete-conflicting-outputs` após criar/alterar anotações.

---

## 3. Error Handling (fpdart)

### Failures (Domain — o que a UI conhece)

```dart
// core/error/failures.dart
sealed class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erro no servidor']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Erro no cache local']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Erro de autenticação']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sem conexão com a internet']);
}
```

### Exceptions (Data — detalhes de implementação)

```dart
// core/error/exceptions.dart
class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Erro no servidor']);
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Erro no cache']);
}
```

### Typedefs

```dart
// core/utils/typedefs.dart
import 'package:fpdart/fpdart.dart';
import 'package:barber_flow/core/error/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
```

### Contrato UseCase

```dart
// core/usecases/usecase.dart
import 'package:barber_flow/core/utils/typedefs.dart';

abstract class UseCase<Type, Params> {
  FutureEither<Type> call(Params params);
}

class NoParams {
  const NoParams();
}
```

### Fluxo entre camadas

```
DataSource lança Exception
    ↓
Repository captura e converte → Either<Failure, T>
    ↓
UseCase propaga o Either (sem try/catch)
    ↓
BLoC faz fold() → emite estado de erro ou sucesso
```

A camada Domain nunca faz try/catch — é 100% pura e testável.

---

## 4. Firebase Core — Inicialização Preparada

### Entry point

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // Descomentar após `flutterfire configure`
import 'package:barber_flow/core/di/injection_container.dart';
import 'package:barber_flow/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Descomentar a linha acima após criar o projeto no Firebase e rodar `flutterfire configure`
  configureDependencies();
  runApp(const App());
}
```

### Passos futuros (quando o usuário criar o projeto Firebase)

1. Rodar `flutterfire configure` → gera `firebase_options.dart`
2. Copiar `google-services.json` → `android/app/`
3. Copiar `GoogleService-Info.plist` → `ios/Runner/`
4. Descomentar as linhas de Firebase no `main.dart`
5. Preencher variáveis reais no `.env`

---

## 5. Segurança

### .env (raiz do projeto — NÃO commitado)

```env
GOOGLE_MAPS_API_KEY=PLACEHOLDER
```

### .env.example (commitado — guia para devs)

```env
# Copie este arquivo para .env e preencha os valores reais
GOOGLE_MAPS_API_KEY=
```

### Adições ao .gitignore

```gitignore
# Segurança - Credenciais e configs sensíveis
.env
.env.*
**/google-services.json
**/GoogleService-Info.plist
**/firebase_options.dart
```

### Regra: zero hardcode

Conforme skill 01, nenhuma chave de API, token ou senha pode existir no código-fonte. Tudo via `dotenv.env['CHAVE']`.

---

## 6. Dependências (pubspec.yaml)

### dependencies

| Pacote | Versão | Função |
|---|---|---|
| `flutter_bloc` | latest | BLoC/Cubit state management |
| `get_it` | latest | Service Locator |
| `injectable` | latest | Anotações DI |
| `fpdart` | latest | Either, programação funcional |
| `flutter_dotenv` | latest | Variáveis de ambiente |
| `equatable` | latest | Comparação de objetos/estados |
| `firebase_core` | latest | Firebase base |
| `firebase_auth` | latest | Autenticação Firebase |
| `cloud_firestore` | latest | Firestore |
| `google_sign_in` | latest | Google OAuth |

### dev_dependencies

| Pacote | Versão | Função |
|---|---|---|
| `injectable_generator` | latest | Code-gen para injectable |
| `build_runner` | latest | Executor de code-gen |

---

## 7. Git — Fluxo desta tarefa

Conforme skill 02:
1. Criar branch `develop` a partir de `main`
2. Criar branch `feature/clean-architecture-setup` a partir de `develop`
3. Commits com Conventional Commits:
   - `chore: configura .gitignore e .env para segurança`
   - `chore: adiciona dependências ao pubspec.yaml`
   - `feat: implementa estrutura clean architecture com DI e error handling`
   - `feat: prepara inicialização do Firebase`
4. Merge para `develop` e checkout de volta

---

## Verificação

- [ ] `flutter pub get` — dependências resolvidas sem conflito
- [ ] `dart run build_runner build` — code-gen do injectable gera `injection_container.config.dart`
- [ ] `flutter analyze` — zero warnings/errors
- [ ] `.env` e arquivos sensíveis ausentes do tracking git (`git status`)
- [ ] Estrutura de pastas confere com a árvore documentada
