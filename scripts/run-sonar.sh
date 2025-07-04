#!/bin/bash

set -e

docker run --rm \
    -v $(pwd):/usr/src \
    --network learning-sonar-dep-checker_shared_network \
    sonarsource/sonar-scanner-cli:latest \
    sonar-scanner \
    -Dsonar.token="<your-sonar-token-here>" \
    -Dsonar.host.url="http://sonarqube:9000/"
