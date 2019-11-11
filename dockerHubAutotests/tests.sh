#!/bin/sh
echo "Available environment variables:"
env

echo "Wait for Trivy scan result..."
timeout=0
while [ ! -f /projectroot/report.json ]; do
    sleep 1
    timeout=$((timeout + 1))
    if [ $timeout -ge 600 ]; then
        echo "Exit due to a timeout. We do not want to wait longer then 10 minutes."
        exit
    fi
done

echo "Send report to Trivy Report Registry..."
curl -X POST -H "Content-Type: application/json" -d @/projectroot/report.json https://trivy-report-registry.ff-hamm.de/incomming-report

echo "Tests successful."
exit 0