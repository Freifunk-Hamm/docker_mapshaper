#!/bin/sh
echo "Install curl"
apk --no-cache add curl

echo "Available environment variables:"
env

echo "Trivy version"
trivy -v

echo "Docker images:"
docker image list
echo "Export docker image as: this.tar"
docker save this:latest -o this.tar
ls -al this.tar

echo "Clean-up trivy cache (to get rid of old artifacts from previous runs):"
trivy --clear-cache

DOCKER_REPO_NO_REG=$(echo $IMAGE_NAME | awk -F"/" '{print $2 "/" $3}')
echo "Temp. docker image name is: ${DOCKER_REPO_NO_REG}"
echo "Temp. docker image name is: this:latest"
echo "Official docker image name is: ${DOCKER_REPO}:${DOCKER_TAG}"

echo "Generate vulnerability report..."
trivy -d --no-progress --format json --output /projectroot/report.json  --input this.tar
echo "Show vulnerabilities summary: "
trivy -d --quiet  --input this.tar

echo "Current directory contents:"
ls -al /projectroot

echo "Content of Trivy Report"
cat /projectroot/report.json
echo ""

echo "Send report to Trivy Report Registry..."
curl -X POST -H "Content-Type: application/json" --silent --data-binary "@/projectroot/report.json" https://trivy-report-registry.ff-hamm.de/incoming-report
echo "done."

# fails if vulnerabilities of a notable severity are detected:
trivy -d --quiet --severity CRITICAL,HIGH --exit-code 1  --input this.tar > /dev/null 2>&1
exitCode=$?
if [ $exitCode -gt 0 ]; then
  echo "Tests failed! Notable vulnerabilities are detected!"
  exit 1
fi

echo "Tests successful."
exit 0
