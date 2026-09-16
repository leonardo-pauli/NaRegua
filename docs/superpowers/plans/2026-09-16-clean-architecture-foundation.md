# Clean Architecture Foundation — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Estabelecer a fundação arquitetural completa do BarberFlow com Clean Architecture feature-first, DI via get_it+injectable, error handling funcional via fpdart, e inicialização Firebase preparada.

**Architecture:** Feature-first Clean Architecture com `core/` centralizado e `features/` autocontidas. Cada feature contém domain/data/presentation. Injeção de dependências com get_it+injectable (Service Locator com code-gen). Error handling funcional com fpdart Either.

**Tech Stack:** Flutter 3.12+, firebase_core, firebase_auth, cloud_firestore, google_sign_in, flutter_bloc, get_it, injectable, injectable_generator, build_runner, fpdart, flutter_dotenv, equatable

**Spec:** [2026-09-16-clean-architecture-foundation-design.md](file:///c:/Flutter%20Apps/barber_flow/docs/superpowers/specs/2026-09-16-clean-architecture-foundation-design.md)

## Global Constraints

- Dart SDK: ^3.12.1
- Flutter: uses-material-design: true
- Conventional Commits obrigatórios (skill 02)
- Zero hardcode de chaves/tokens (skill 01)
- Limite de 150-200 linhas por widget/classe (skill 04)
- Branch de trabalho: `feature/clean-architecture-setup` a partir de `develop`
- Package name: `barber_flow`

---

## File Map

### Files to Create

| Path | Responsibility |
|---|---|
| `.env` | Variáveis de ambiente (não commitado) |
| `.env.example` | Template de variáveis (commitado) |
| `lib/main.dart` | Entry point — inicializa DI, dotenv, Firebase |
| `lib/app.dart` | MaterialApp com tema e rotas |
| `lib/core/di/injection_container.dart` | GetIt + @InjectableInit |
| `lib/core/di/register_module.dart` | Módulo para dependências externas (Firebase) |
| `lib/core/error/failures.dart` | Sealed class Failure e subclasses |
| `lib/core/error/exceptions.dart` | Exceptions da camada Data |
| `lib/core/usecases/usecase.dart` | Contrato base UseCase |
| `lib/core/utils/typedefs.dart` | FutureEither, FutureVoid |
| `lib/core/theme/app_theme.dart` | Tema global (cores, tipografia) |
| `lib/core/routes/app_router.dart` | Navegação centralizada |
| `lib/core/constants/app_constants.dart` | Strings e constantes globais |
| `lib/core/network/network_info.dart` | Abstração de conectividade |
| `lib/features/auth/domain/entities/user_entity.dart` | Entidade User do domínio |
| `lib/features/auth/domain/repositories/auth_repository.dart` | Contrato abstrato do repositório |
| `lib/features/auth/domain/usecases/sign_in_with_google.dart` | UseCase SignInWithGoogle |
| `lib/features/auth/data/models/user_model.dart` | Model que implementa UserEntity |
| `lib/features/auth/data/datasources/auth_remote_datasource.dart` | Contrato + impl do datasource |
| `lib/features/auth/data/repositories/auth_repository_impl.dart` | Implementação concreta do repositório |
| `lib/features/auth/presentation/bloc/auth_bloc.dart` | BLoC de autenticação |
| `lib/features/auth/presentation/bloc/auth_event.dart` | Eventos do AuthBloc |
| `lib/features/auth/presentation/bloc/auth_state.dart` | Estados do AuthBloc |

### Files to Modify

| Path | Change |
|---|---|
| `.gitignore` | Adicionar regras de segurança (.env, google-services.json, etc) |
| `pubspec.yaml` | Adicionar todas as dependências |

---

### Task 1: Git Setup e Segurança

**Files:**
- Modify: `.gitignore`
- Create: `.env`
- Create: `.env.example`

**Interfaces:**
- Consumes: nada (task raiz)
- Produces: `.env` com `GOOGLE_MAPS_API_KEY` disponível via `dotenv.env['GOOGLE_MAPS_API_KEY']`

- [ ] **Step 1: Criar branch `develop` e `feature/clean-architecture-setup`**

```bash
git checkout -b develop
git checkout -b feature/clean-architecture-setup
```

- [ ] **Step 2: Atualizar `.gitignore` com regras de segurança**

Adicionar ao final do `.gitignore` existente:

```gitignore
# Segurança - Credenciais e configs sensíveis
.env
.env.*
**/google-services.json
**/GoogleService-Info.plist
**/firebase_options.dart

# Generated files
*.config.dart
*.g.dart
*.freezed.dart
```

- [ ] **Step 3: Criar `.env`**

```env
GOOGLE_MAPS_API_KEY=PLACEHOLDER
```

- [ ] **Step 4: Criar `.env.example`**

```env
# Copie este arquivo para .env e preencha os valores reais
GOOGLE_MAPS_API_KEY=
```

- [ ] **Step 5: Verificar que `.env` não é rastreado**

```bash
git status
```

Expected: `.env` NÃO aparece na lista de untracked/staged files. `.env.example` aparece.

- [ ] **Step 6: Commit**

```bash
git add .gitignore .env.example
git commit -m "chore: configura .gitignore e .env para segurança"
```

---

### Task 2: Dependências

**Files:**
- Modify: `pubspec.yaml`

**Interfaces:**
- Consumes: nada
- Produces: Todos os pacotes disponíveis para import

- [ ] **Step 1: Atualizar `pubspec.yaml` com todas as dependências**

```yaml
name: barber_flow
description: "App de agendamento de barbearias"
publish_to: 'none'
version: 0.1.0+1

environment:
  sdk: ^3.12.1

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^9.1.0
  equatable: ^2.0.7

  # Dependency Injection
  get_it: ^8.0.3
  injectable: ^2.5.0

  # Functional Programming
  fpdart: ^1.1.1

  # Environment Variables
  flutter_dotenv: ^5.2.1

  # Firebase
  firebase_core: ^3.13.0
  firebase_auth: ^5.7.0
  cloud_firestore: ^5.10.0

  # Google Sign In
  google_sign_in: ^6.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

  # DI Code Generation
  injectable_generator: ^2.6.3
  build_runner: ^2.4.15

flutter:
  uses-material-design: true
  assets:
    - .env
```

- [ ] **Step 2: Executar `flutter pub get`**

```bash
flutter pub get
```

Expected: Todas as dependências resolvidas sem conflito.

- [ ] **Step 3: Commit**

```bash
git add pubspec.yaml pubspec.lock
git commit -m "chore: adiciona dependências (bloc, get_it, injectable, fpdart, firebase, dotenv)"
```

---

### Task 3: Core — Error Handling e Utils

**Files:**
- Create: `lib/core/error/failures.dart`
- Create: `lib/core/error/exceptions.dart`
- Create: `lib/core/utils/typedefs.dart`
- Create: `lib/core/usecases/usecase.dart`

**Interfaces:**
- Consumes: pacote `fpdart` (Task 2)
- Produces:
  - `sealed class Failure` com subclasses `ServerFailure`, `CacheFailure`, `AuthFailure`, `NetworkFailure`
  - `class ServerException`, `class CacheException`
  - `typedef FutureEither<T> = Future<Either<Failure, T>>`
  - `typedef FutureVoid = FutureEither<void>`
  - `abstract class UseCase<Type, Params>` com método `FutureEither<Type> call(Params params)`
  - `class NoParams`

- [ ] **Step 1: Criar `lib/core/error/failures.dart`**

```dart
import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
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

- [ ] **Step 2: Criar `lib/core/error/exceptions.dart`**

```dart
class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Erro no servidor']);

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Erro no cache']);

  @override
  String toString() => 'CacheException: $message';
}
```

- [ ] **Step 3: Criar `lib/core/utils/typedefs.dart`**

```dart
import 'package:fpdart/fpdart.dart';
import 'package:barber_flow/core/error/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
```

- [ ] **Step 4: Criar `lib/core/usecases/usecase.dart`**

```dart
import 'package:barber_flow/core/utils/typedefs.dart';

abstract class UseCase<Type, Params> {
  FutureEither<Type> call(Params params);
}

class NoParams {
  const NoParams();
}
```

- [ ] **Step 5: Executar `flutter analyze`**

```bash
flutter analyze
```

Expected: Zero errors nos 4 arquivos criados.

- [ ] **Step 6: Commit**

```bash
git add lib/core/error/ lib/core/utils/ lib/core/usecases/
git commit -m "feat: implementa error handling (failures, exceptions) e base usecase"
```

---

### Task 4: Core — Injeção de Dependências

**Files:**
- Create: `lib/core/di/injection_container.dart`
- Create: `lib/core/di/register_module.dart`

**Interfaces:**
- Consumes: pacotes `get_it`, `injectable`, `firebase_auth`, `cloud_firestore`, `google_sign_in` (Task 2)
- Produces:
  - `final GetIt sl = GetIt.instance` — service locator global
  - `void configureDependencies()` — inicializa todos os registros
  - `RegisterModule` — fornece instâncias Firebase ao get_it

- [ ] **Step 1: Criar `lib/core/di/injection_container.dart`**

```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final sl = GetIt.instance;

@InjectableInit()
void configureDependencies() => sl.init();
```

- [ ] **Step 2: Criar `lib/core/di/register_module.dart`**

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

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

- [ ] **Step 3: Executar build_runner para gerar `injection_container.config.dart`**

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: Gera `lib/core/di/injection_container.config.dart` sem erros.

- [ ] **Step 4: Executar `flutter analyze`**

```bash
flutter analyze
```

Expected: Zero errors.

- [ ] **Step 5: Commit**

```bash
git add lib/core/di/
git commit -m "feat: configura injeção de dependências (get_it + injectable)"
```

---

### Task 5: Core — Theme, Routes, Constants e Network

**Files:**
- Create: `lib/core/theme/app_theme.dart`
- Create: `lib/core/routes/app_router.dart`
- Create: `lib/core/constants/app_constants.dart`
- Create: `lib/core/network/network_info.dart`

**Interfaces:**
- Consumes: nada
- Produces:
  - `class AppTheme` com `static ThemeData get lightTheme` e `static ThemeData get darkTheme`
  - `class AppRouter` com `static Route<dynamic> onGenerateRoute(RouteSettings)` e constantes `splash`, `login`, `home`
  - `class AppConstants` com `appName`, `appVersion`, nomes de coleções Firestore
  - `abstract class NetworkInfo` com `Future<bool> get isConnected`

- [ ] **Step 1: Criar `lib/core/theme/app_theme.dart`**

```dart
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Paleta de cores base (será refinada com o Figma)
  static const Color primaryColor = Color(0xFF1A1A2E);
  static const Color secondaryColor = Color(0xFF16213E);
  static const Color accentColor = Color(0xFFE94560);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: accentColor,
      scaffoldBackgroundColor: primaryColor,
    );
  }
}
```

- [ ] **Step 2: Criar `lib/core/routes/app_router.dart`**

```dart
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Rotas serão adicionadas conforme features forem implementadas
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Rota não encontrada'),
            ),
          ),
        );
    }
  }
}
```

- [ ] **Step 3: Criar `lib/core/constants/app_constants.dart`**

```dart
class AppConstants {
  AppConstants._();

  static const String appName = 'NaRegua';
  static const String appVersion = '0.1.0';

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String barbersCollection = 'barbers';
  static const String appointmentsCollection = 'appointments';
  static const String servicesCollection = 'services';
}
```

- [ ] **Step 4: Criar `lib/core/network/network_info.dart`**

```dart
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// Implementação concreta será adicionada com o pacote connectivity_plus
// quando features de rede forem implementadas
```

- [ ] **Step 5: Executar `flutter analyze`**

```bash
flutter analyze
```

Expected: Zero errors.

- [ ] **Step 6: Commit**

```bash
git add lib/core/theme/ lib/core/routes/ lib/core/constants/ lib/core/network/
git commit -m "feat: adiciona tema, rotas, constantes e abstração de rede"
```

---

### Task 6: Feature Auth — Domain Layer

**Files:**
- Create: `lib/features/auth/domain/entities/user_entity.dart`
- Create: `lib/features/auth/domain/repositories/auth_repository.dart`
- Create: `lib/features/auth/domain/usecases/sign_in_with_google.dart`

**Interfaces:**
- Consumes:
  - `FutureEither<T>` de `core/utils/typedefs.dart` (Task 3)
  - `UseCase<Type, Params>`, `NoParams` de `core/usecases/usecase.dart` (Task 3)
- Produces:
  - `class UserEntity extends Equatable` com props: `String uid`, `String name`, `String email`, `String? photoUrl`, `String role` (default `'client'`)
  - `abstract class AuthRepository` com `FutureEither<UserEntity> signInWithGoogle()`, `FutureEither<void> signOut()`
  - `class SignInWithGoogle extends UseCase<UserEntity, NoParams>`

- [ ] **Step 1: Criar `lib/features/auth/domain/entities/user_entity.dart`**

```dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String role; // 'client' ou 'barber'

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.role = 'client',
  });

  @override
  List<Object?> get props => [uid, name, email, photoUrl, role];
}
```

- [ ] **Step 2: Criar `lib/features/auth/domain/repositories/auth_repository.dart`**

```dart
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  FutureEither<UserEntity> signInWithGoogle();
  FutureEither<void> signOut();
}
```

- [ ] **Step 3: Criar `lib/features/auth/domain/usecases/sign_in_with_google.dart`**

```dart
import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';
import 'package:barber_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInWithGoogle extends UseCase<UserEntity, NoParams> {
  final AuthRepository _repository;

  SignInWithGoogle(this._repository);

  @override
  FutureEither<UserEntity> call(NoParams params) {
    return _repository.signInWithGoogle();
  }
}
```

- [ ] **Step 4: Executar `flutter analyze`**

```bash
flutter analyze
```

Expected: Zero errors nos 3 arquivos da camada domain.

- [ ] **Step 5: Commit**

```bash
git add lib/features/auth/domain/
git commit -m "feat: implementa domain layer da feature auth (entity, repository, usecase)"
```

---

### Task 7: Feature Auth — Data Layer

**Files:**
- Create: `lib/features/auth/data/models/user_model.dart`
- Create: `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- Create: `lib/features/auth/data/repositories/auth_repository_impl.dart`

**Interfaces:**
- Consumes:
  - `UserEntity` de `features/auth/domain/entities/user_entity.dart` (Task 6)
  - `AuthRepository` de `features/auth/domain/repositories/auth_repository.dart` (Task 6)
  - `ServerException` de `core/error/exceptions.dart` (Task 3)
  - `Failure`, `ServerFailure`, `AuthFailure` de `core/error/failures.dart` (Task 3)
  - `FutureEither<T>` de `core/utils/typedefs.dart` (Task 3)
  - `FirebaseAuth`, `FirebaseFirestore`, `GoogleSignIn` do `RegisterModule` (Task 4)
- Produces:
  - `class UserModel extends UserEntity` com `factory UserModel.fromMap(Map<String, dynamic>)`, `Map<String, dynamic> toMap()`, `factory UserModel.fromFirebaseUser(User user)`
  - `abstract class AuthRemoteDataSource` com `Future<UserModel> signInWithGoogle()`, `Future<void> signOut()`
  - `class AuthRemoteDataSourceImpl implements AuthRemoteDataSource` anotado com `@LazySingleton(as: AuthRemoteDataSource)`
  - `class AuthRepositoryImpl implements AuthRepository` anotado com `@LazySingleton(as: AuthRepository)`

- [ ] **Step 1: Criar `lib/features/auth/data/models/user_model.dart`**

```dart
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.photoUrl,
    super.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String?,
      role: map['role'] as String? ?? 'client',
    );
  }

  factory UserModel.fromFirebaseUser(firebase.User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
    };
  }
}
```

- [ ] **Step 2: Criar `lib/features/auth/data/datasources/auth_remote_datasource.dart`**

```dart
import 'package:barber_flow/core/error/exceptions.dart';
import 'package:barber_flow/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firestore,
    this._googleSignIn,
  );

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const ServerException('Login com Google cancelado');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user == null) {
        throw const ServerException('Usuário não encontrado após login');
      }

      final userModel = UserModel.fromFirebaseUser(user);

      // Salva/atualiza dados do usuário no Firestore
      await _firestore.collection('users').doc(user.uid).set(
            userModel.toMap(),
            SetOptions(merge: true),
          );

      return userModel;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Erro ao fazer login com Google: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw ServerException('Erro ao fazer logout: $e');
    }
  }
}
```

- [ ] **Step 3: Criar `lib/features/auth/data/repositories/auth_repository_impl.dart`**

```dart
import 'package:barber_flow/core/error/exceptions.dart';
import 'package:barber_flow/core/error/failures.dart';
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';
import 'package:barber_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  FutureEither<UserEntity> signInWithGoogle() async {
    try {
      final user = await _remoteDataSource.signInWithGoogle();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('Erro inesperado: $e'));
    }
  }

  @override
  FutureEither<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Erro ao fazer logout: $e'));
    }
  }
}
```

- [ ] **Step 4: Executar `flutter analyze`**

```bash
flutter analyze
```

Expected: Zero errors na camada data.

- [ ] **Step 5: Commit**

```bash
git add lib/features/auth/data/
git commit -m "feat: implementa data layer da feature auth (model, datasource, repository)"
```

---

### Task 8: Feature Auth — Presentation Layer (BLoC)

**Files:**
- Create: `lib/features/auth/presentation/bloc/auth_event.dart`
- Create: `lib/features/auth/presentation/bloc/auth_state.dart`
- Create: `lib/features/auth/presentation/bloc/auth_bloc.dart`

**Interfaces:**
- Consumes:
  - `SignInWithGoogle` de `features/auth/domain/usecases/sign_in_with_google.dart` (Task 6)
  - `NoParams` de `core/usecases/usecase.dart` (Task 3)
  - `UserEntity` de `features/auth/domain/entities/user_entity.dart` (Task 6)
- Produces:
  - `sealed class AuthEvent` com `SignInWithGoogleEvent`, `SignOutEvent`
  - `sealed class AuthState extends Equatable` com `AuthInitial`, `AuthLoading`, `AuthSuccess(UserEntity user)`, `AuthError(String message)`
  - `class AuthBloc extends Bloc<AuthEvent, AuthState>` anotado com `@injectable`

- [ ] **Step 1: Criar `lib/features/auth/presentation/bloc/auth_event.dart`**

```dart
sealed class AuthEvent {
  const AuthEvent();
}

class SignInWithGoogleEvent extends AuthEvent {
  const SignInWithGoogleEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
```

- [ ] **Step 2: Criar `lib/features/auth/presentation/bloc/auth_state.dart`**

```dart
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
```

- [ ] **Step 3: Criar `lib/features/auth/presentation/bloc/auth_bloc.dart`**

```dart
import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_event.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle _signInWithGoogle;

  AuthBloc(this._signInWithGoogle) : super(const AuthInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signInWithGoogle(const NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthInitial());
  }
}
```

- [ ] **Step 4: Executar `flutter analyze`**

```bash
flutter analyze
```

Expected: Zero errors na camada presentation.

- [ ] **Step 5: Commit**

```bash
git add lib/features/auth/presentation/
git commit -m "feat: implementa BLoC de autenticação (events, states, bloc)"
```

---

### Task 9: Entry Point e App Shell

**Files:**
- Modify: `lib/main.dart`
- Create: `lib/app.dart`

**Interfaces:**
- Consumes:
  - `configureDependencies()` de `core/di/injection_container.dart` (Task 4)
  - `AppTheme` de `core/theme/app_theme.dart` (Task 5)
  - `AppRouter` de `core/routes/app_router.dart` (Task 5)
  - `AppConstants` de `core/constants/app_constants.dart` (Task 5)
- Produces:
  - `Future<void> main()` — entry point funcional com DI e dotenv inicializados
  - `class App extends StatelessWidget` — MaterialApp configurado com tema, rotas e debug banner desativado

- [ ] **Step 1: Reescrever `lib/main.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:barber_flow/core/di/injection_container.dart';
import 'package:barber_flow/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Descomentar após criar o projeto no Firebase e rodar `flutterfire configure`:
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  configureDependencies();
  runApp(const App());
}
```

- [ ] **Step 2: Criar `lib/app.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:barber_flow/core/constants/app_constants.dart';
import 'package:barber_flow/core/routes/app_router.dart';
import 'package:barber_flow/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.splash,
    );
  }
}
```

- [ ] **Step 3: Executar build_runner para atualizar registros DI**

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: `injection_container.config.dart` regenerado com todos os registros.

- [ ] **Step 4: Executar `flutter analyze`**

```bash
flutter analyze
```

Expected: Zero errors em todo o projeto.

- [ ] **Step 5: Commit**

```bash
git add lib/main.dart lib/app.dart
git commit -m "feat: configura entry point com DI, dotenv e app shell"
```

---

### Task 10: Merge e Finalização

**Files:** Nenhum arquivo modificado — apenas operações Git.

**Interfaces:**
- Consumes: todos os commits das Tasks 1-9
- Produces: branch `develop` atualizada com toda a fundação

- [ ] **Step 1: Verificação final completa**

```bash
flutter analyze
```

Expected: Zero errors em todo o projeto.

- [ ] **Step 2: Verificar que arquivos sensíveis NÃO estão no Git**

```bash
git status
git ls-files | findstr ".env"
```

Expected: Nenhum `.env` no tracking. Apenas `.env.example` commitado.

- [ ] **Step 3: Commit final se houver algo pendente**

```bash
git status
```

Se houver algo pendente, commit com mensagem apropriada.

- [ ] **Step 4: Merge para `develop`**

```bash
git checkout develop
git merge feature/clean-architecture-setup
```

- [ ] **Step 5: Push**

```bash
git push -u origin develop
```

- [ ] **Step 6: Confirmar checkout em `develop`**

```bash
git branch
```

Expected: `* develop`
