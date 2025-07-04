#!/bin/bash

set -e

DC_VERSION="latest"
DC_DIRECTORY=$HOME/.OWASP-Dependency-Check
DC_PROJECT="dependency-check scan: $(pwd)"
DATA_DIRECTORY="$DC_DIRECTORY/data"
CACHE_DIRECTORY="$DC_DIRECTORY/data/cache"
REPORTS_DIRECTORY="$(pwd)/reports"

NVD_API_KEY="<your-nvd-api-key-here>"

if [ ! -d "$DATA_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $DATA_DIRECTORY"
    mkdir -p "$DATA_DIRECTORY"
fi
if [ ! -d "$CACHE_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $CACHE_DIRECTORY"
    mkdir -p "$CACHE_DIRECTORY"
fi
if [ ! -d "$REPORTS_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $REPORTS_DIRECTORY"
    mkdir -p "$REPORTS_DIRECTORY"
fi

# Make sure we are using the latest version
docker pull owasp/dependency-check:$DC_VERSION

docker run --rm \
    -e user=$USER \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    --volume "$(pwd)":/src:z \
    --volume "$DATA_DIRECTORY":/usr/share/dependency-check/data:z \
    --volume "$REPORTS_DIRECTORY":/report:z \
    owasp/dependency-check:$DC_VERSION \
    --scan /src \
    --format "HTML" \
    --format "JSON" \
    --project "$DC_PROJECT" \
    --out /report \
    --nvdApiKey "$NVD_API_KEY"
    # Use suppression like this: (where /src == $pwd)
    # --suppression "/src/security/dependency-check-suppression.xml"
