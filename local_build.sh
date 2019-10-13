#!/usr/bin/env bash
# This script is not used for official releases - it is just available here for your local development convenience
# This github repository is triggering docker hub on every push to master branch.
# New docker image will be build automatically and pushed as "latest" and with version number (see git tag) to docker hub.


# Delete old "latest" image
docker image rm freifunk/mapshaper:latest

# Build a new "latest" image
docker build --file Dockerfile --tag freifunk/mapshaper:latest .

# Get current version
# Even if this issue (https://github.com/mbloch/mapshaper/issues/364) got fixed we will keep the redirect to stay backward compatible in this build script)
version=$(docker run --rm freifunk/mapshaper:latest --version 2>&1)
echo $version
echo $SHELL

# Tag image with current version string, too
docker tag freifunk/mapshaper:latest freifunk/mapshaper:${version}

# Display build artifacts
docker image list | grep freifunk/mapshaper
