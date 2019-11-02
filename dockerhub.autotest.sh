#!/bin/sh
echo "Execute another docker container from within this test environment container:"
docker pull hello-world
docker run --rm hello-world
echo "Tests successful."
exit 0