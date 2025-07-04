# Learning Sonar Dependency Checker

1. Install dependencies:
    ```bash
    yarn install
    ```

1. Run Docker Compose to start the SonarQube server:
    ```bash
    docker-compose up -d
    ```

    > If you are using Windows, you may need to create the directorys `.\sonar-data\es8`, `.\sonar-data\web` and `.\sonar-extensions\downloads` manually to avoid permission issues.

1. Access SonarQube at `http://localhost:9000` and log in with the default credentials:
    - Username: `admin`
    - Password: `admin`

1. Install Dependency Check extension in SonarQube:
    - Go to `Administration` > `Marketplace`
    - Search for `Dependency-Check`
    - Install the extension and restart SonarQube

1. Create a user key to request the SonarQube API:
    - Go to `My Account` > `Security` > `Generate Tokens`
    - Name the token (e.g., `sonar-token`) and click `Generate`
    - Copy the generated token
    - Paste the token in the `clientId` variable [here](src\index.ts)

1. Run dependency check and sonar analysis on a project of your choice
    - Update the `projectKey` variable in [src/index.ts](src/index.ts) with your project key
    - Example scripts [here](./scripts)

1. Run this script to get the dependency check results:
    ```bash
    yarn dev
    ```
