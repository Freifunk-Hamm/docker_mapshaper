#!/usr/bin/env bash
# This github repository is triggering docker hub on every push to master branch.
# New docker image will be build automatically and pushed as "latest" and with version number (see git tag) to docker hub.
echo "This script is not used for official releases - it is just available here for your local development convenience"

# Delete old "latest" image
docker image rm freifunkhamm/mapshaper:latest

# Build a new "latest" image
docker build --file Dockerfile --tag freifunkhamm/mapshaper:latest .

# Get current version
# Even if this issue (https://github.com/mbloch/mapshaper/issues/364) got fixed we will keep the redirect to stay backward compatible in this build script)
version=$(docker run --rm freifunkhamm/mapshaper:latest --version 2>&1)
echo "${version}"
echo "${SHELL}"

# Tag image with current version string, too
docker tag freifunkhamm/mapshaper:latest "freifunkhamm/mapshaper:${version}"

# Display build artifacts
docker image list | grep freifunkhamm/mapshaper
