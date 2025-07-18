# Aprendendo sobre o OWASP Dependency-Check no SonarQube

- [🇺🇸 English](./README.md)
- [🇧🇷 Português (Brasil)](./README.pt-br.md)

Essa documentação guia você pelo uso do OWASP Dependency-Check integrado ao SonarQube.

## Pré-requisitos

- Docker e Docker Compose instalados
- (Opcional) Node.js e Yarn instalados

## Executando o SonarQube localmente

Caso ainda não tenha, configure um servidor SonarQube local para testes e integrações.

1. Execute o Docker Compose para iniciar o servidor SonarQube:
    ```bash
    docker-compose up -d
    ```

1. Acesse o SonarQube no endereço `http://localhost:9000` e faça login com as credenciais padrão:
    - Nome de usuário: `admin`
    - Senha: `admin`

1. Instale a extensão Dependency-Check no SonarQube:
    - Vá para `Administration` > `Marketplace`
    - Pesquise por `Dependency-Check`
    - Instale a extensão e reinicie o SonarQube

1. Crie uma chave de usuário para fazer requisições à API do SonarQube:
    - Vá para `My Account` > `Security` > `Generate Tokens`
    - Nomeie o token (por exemplo, `sonar-token`) e clique em `Generate`
    - Copie e salve o token gerado

## Executando o Dependency-Check

Execute a ferramenta para verificar vulnerabilidades em dependências de um projeto.

1. Execute o dependency-check em um projeto de sua preferência.
    - Copie o script de exemplos [aqui](./examples/run-dependency-checker.sh)
    - (Opcional) Substitua `NVD_API_KEY` no script pela sua chave de API do NVD (obtenha uma gratuita no [NVD](https://nvd.nist.gov/developers/request-an-api-key))
    - Execute o script:
        ```bash
        ./run-dependency-checker.sh
        ```

1. Verifique os arquivos de saída:
    - O script gera dois arquivos: `./odc-reports/dependency-check-report.json` e `./odc-reports/dependency-check-report.html`
    - Esses arquivos contêm os resultados da verificação de dependências

## Executando o Sonar Scanner

Rode o Sonar Scanner para enviar os resultados do Dependency-Check ao SonarQube.

1. Atualize a configuração do Sonar no projeto para carregar os arquivos de saída do Dependency-Check
    - Veja a configuração de exemplo [aqui](./examples/example-sonar-project.properties)
    - Atualize as variáveis `sonar.dependencyCheck.jsonReportPath` e `sonar.dependencyCheck.htmlReportPath` com o caminho para os seus arquivos de saída do Dependency-Check.

1. Execute o Sonar Scanner para analisar o projeto e enviar os resultados do Dependency-Check:
    - Copie o script de exemplos [aqui](./examples/run-sonar-scanner.sh)
    - Atualize as variáveis `-Dsonar.token` e `-Dsonar.host.url` com o seu token do SonarQube e a URL.
    - Execute o script:
        ```bash
        ./run-sonar-scanner.sh
        ```

1. Aguarde a análise ser concluída e verifique o dashboard do SonarQube:
    - Vá para `http://localhost:9000/projects`
    - Clique no seu projeto para visualizar os resultados da análise
    - Na aba Measures, você deve ver os resultados do Dependency-Check na seção "OWASP-Dependency-Check"
    - Você também pode visualizar o relatório do Dependency-Check clicando na aba "More" e selecionando "Dependency Check"

## Obtendo os resultados do Dependency-Check pela API do SonarQube

Acesse os resultados via API para automações ou integrações personalizadas.

1. Dê uma olhada no script de exemplo [aqui](./src/index.ts)
    - Copie o arquivo `.env-default` para `.env` e atualize as variáveis com o seu token do SonarQube e a URL.
    - Execute o script:
        ```bash
        yarn install
        yarn dev
        ```
