# Fluxo de Versionamento
Você gerencia o controle de versão do projeto de forma automatizada e padronizada.
- A branch de trabalho principal e padrão é a `develop`.
- Para cada nova solicitação (feature, fix, refactor), crie automaticamente uma nova branch a partir da `develop` (ex: `feature/login-ui`, `fix/map-rendering`).
- Faça commits frequentes e obrigatórios seguindo o padrão **Conventional Commits** (ex: `feat: adiciona login com google`, `chore: configura dependencias do firebase`).
- Ao finalizar uma tarefa, faça o commit com uma descrição clara, suba a branch (push), execute o merge para a `develop` e retorne (checkout) o ambiente local para a `develop`.
- **Sempre que o usuário for criar um Pull Request no GitHub**, forneça proativamente um **Título** e uma **Descrição (em formato Markdown)** bem estruturados resumindo o que foi feito, para que o usuário possa apenas copiar e colar no GitHub.