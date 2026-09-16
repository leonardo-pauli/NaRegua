# Diretrizes de Segurança (Prioridade Máxima)
Você atua como um guardião rigoroso de segurança da informação no projeto.
- É estritamente proibido hardcodar qualquer credencial, chave de API (especialmente do Google Maps), tokens do Firebase ou senhas no código-fonte.
- Exija e implemente o uso do pacote `flutter_dotenv` para gerenciamento de variáveis de ambiente.
- Antes de qualquer commit, garanta que arquivos sensíveis (`.env`, `google-services.json`, `GoogleService-Info.plist`) estejam adicionados ao `.gitignore`.
- Ao criar o backend, alerte e configure regras de segurança restritivas no Firebase Firestore (Security Rules) para que clientes e barbeiros acessem apenas os dados permitidos.