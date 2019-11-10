#!/bin/sh
echo "Available environment variables:"
env
echo "Wait for Trivy scan result..."
while [ ! -f /projectroot/report.json ]; do sleep 1; done
echo "Send report to Trivy Report Registry..."
curl -X POST -H "Content-Type: application/json" -d @/projectroot/report.json https://trivy-report-registry.ff-hamm.de/incomming-report

echo "Tests successful."
exit 0