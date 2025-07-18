# Learning OWASP Dependency-Check on SonarQube

- [🇺🇸 English](./README.md)
- [🇧🇷 Português (Brasil)](./README.pt-br.md)

This documentation guides you through using OWASP Dependency-Check integrated with SonarQube.

## Prerequisites

- Docker and Docker Compose installed
- (Optional) Node.js and Yarn installed

## Running SonarQube Locally

If you don't have one yet, set up a local SonarQube server for testing and integrations.

1. Run Docker Compose to start the SonarQube server:
    ```bash
    docker-compose up -d
    ```

1. Access SonarQube at `http://localhost:9000` and log in with the default credentials:
    - Username: `admin`
    - Password: `admin`

1. Install the Dependency-Check extension in SonarQube:
    - Go to `Administration` > `Marketplace`
    - Search for `Dependency-Check`
    - Install the extension and restart SonarQube

1. Create a user key for making requests to the SonarQube API:
    - Go to `My Account` > `Security` > `Generate Tokens`
    - Name the token (for example, `sonar-token`) and click `Generate`
    - Copy and save the generated token

## Running Dependency-Check

Run the tool to check for vulnerabilities in a project's dependencies.

1. Run dependency-check on a project of your choice.
    - Copy the script from examples [here](./examples/run-dependency-checker.sh)
    - (Optional) Replace `NVD_API_KEY` in the script with your NVD API key (get a free one from [NVD](https://nvd.nist.gov/developers/request-an-api-key))
    - Run the script:
        ```bash
        ./run-dependency-checker.sh
        ```

1. Check the output files:
    - The script generates two files: `./odc-reports/dependency-check-report.json` and `./odc-reports/dependency-check-report.html`
    - These files contain the dependency check results

## Running Sonar Scanner

Run the Sonar Scanner to send the Dependency-Check results to SonarQube.

1. Update the Sonar configuration in the project to load the Dependency-Check output files
    - See the example configuration [here](./examples/example-sonar-project.properties)
    - Update the `sonar.dependencyCheck.jsonReportPath` and `sonar.dependencyCheck.htmlReportPath` variables with the path to your Dependency-Check output files.

1. Run the Sonar Scanner to analyze the project and upload the Dependency-Check results:
    - Copy the script from examples [here](./examples/run-sonar-scanner.sh)
    - Update the `-Dsonar.token` and `-Dsonar.host.url` variables with your SonarQube token and URL.
    - Run the script:
        ```bash
        ./run-sonar-scanner.sh
        ```

1. Wait for the analysis to complete and check the SonarQube dashboard:
    - Go to `http://localhost:9000/projects`
    - Click on your project to view the analysis results
    - On the Measures tab, you should see the Dependency-Check results in the "OWASP-Dependency-Check" section
    - You can also view the Dependency-Check report by clicking on the "More" tab and selecting "Dependency Check"

## Getting Dependency-Check Results from the SonarQube API

Access the results via API for automations or custom integrations.

1. Take a look at the example script [here](./src/index.ts)
    - Copy the `.env-default` file to `.env` and update the variables with your SonarQube token and URL.
    - Run the script:
        ```bash
        yarn install
        yarn dev
        ```
