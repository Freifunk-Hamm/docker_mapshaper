#!/bin/sh
echo "Install curl"
apk --no-cache add curl

echo "Available environment variables:"
env

echo "Trivy version"
trivy -v

echo "Generate vulnerability report..."
trivy --no-progress --format json --output /projectroot/report.json "${DOCKER_REPO}:${DOCKER_TAG}"
echo "Show vulnerabilities summary: "
trivy --quiet "${DOCKER_REPO}:${DOCKER_TAG}"

echo "Current directory contents:"
ls -al /projectroot

echo "Content of Trivy Report"
cat /projectroot/report.json
echo ""

echo "Send report to Trivy Report Registry..."
curl -X POST -H "Content-Type: application/json" --silent --data-binary "@/projectroot/report.json" https://trivy-report-registry.ff-hamm.de/incoming-report
echo "done."

# fails if vulnerabilities of a notable severity are detected:
trivy --quiet --severity CRITICAL,HIGH --exit-code 1 "${DOCKER_REPO}:${DOCKER_TAG}" > /dev/null 2>&1
exitCode=$?
if [ $exitCode -gt 0 ]; then
  echo "Tests failed! Notable vulnerabilities are detected!"
  exit 1
fi

echo "Tests successful."
exit 0
