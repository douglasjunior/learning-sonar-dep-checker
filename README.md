# Learning Sonar Dependency Checker

## Pre-requisites

- Docker and Docker Compose installed
- Node.js and Yarn installed
- SonarQube server running

## Running local SonarQube

1. Run Docker Compose to start the SonarQube server:
    ```bash
    docker-compose up -d
    ```

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
    - Copy and save the generated token

## Running Dependency Checker

1. Run dependency on a project of your choice.
    - Copy the script from examples [here](./examples/run-dependency-checker.sh)
    - (Optional) Replace `NVD_API_KEY` in the script with your NVD API key (get a free one from [NVD](https://nvd.nist.gov/developers/request-an-api-key))
    - Run the script:
        ```bash
        ./run-dependency-checker.sh
        ```

1. Check the output files:
    - The script generates two files: `./odc-reports/dependency-check-report.json` and `./odc-reports/dependency-check-report.html`
    - These files contain the results of the dependency check

## Running Sonar Scanner

1. Update the project Sonar configuration to load the Dependency Check output files
    - See example configuration [here](./examples/example-sonar-project.properties)
    - Update the `sonar.dependencyCheck.jsonReportPath` and `sonar.dependencyCheck.htmlReportPath` variable with the path to your Dependency Check output files.

1. Run the Sonar Scanner to analyze the project and upload the Dependency Check results:
    - Copy the script from examples [here](./examples/run-sonar-scanner.sh)
    - Update the `-Dsonar.token` and `-Dsonar.host.url` variables with your SonarQube token and URL.
    - Run the script:
        ```bash
        ./run-sonar-scanner.sh
        ```

1. Wait for the analysis to complete and check the SonarQube dashboard:
    - Go to `http://localhost:9000/projects`
    - Click on your project to view the analysis results
    - On the Measures tab, you should see the Dependency Check results under the "OWASP-Dependency-Check" section
    - You can also view the Dependency Check report by clicking on the "More" tab and selecting "Dependency Check"

## Getting Dependency Check results from SonarQube API

1. Take a look at the example script [here](./src/index.ts)
    - Copy the `.env-default` file to `.env` and update the variables with your SonarQube token and URL.
    - Run the script:
        ```bash
        yarn install
        yarn dev
        ```
