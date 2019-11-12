#!/bin/sh
echo "Available environment variables:"
env

echo "Current directory contents:"
ls -al /projectroot

echo "Wait for Trivy scan result..."
timeout=0
while [ ! -f /projectroot/report.json ]; do
    sleep 1
    timeout=$((timeout + 1))
    if [ $timeout -ge 600 ]; then
        echo "Current directory contents (1000sec):"
        ls -al /projectroot
    fi
    if [ $timeout -ge 1800 ]; then
        echo "Current directory contents (1800sec):"
        ls -al /projectroot
    fi
    if [ $timeout -ge 3000 ]; then
        echo "Current directory contents (3000sec):"
        ls -al /projectroot
    fi
    if [ $timeout -ge 3600 ]; then
        echo "Exit due to a timeout. We do not want to wait longer then 10 minutes."
        exit
    fi
done
echo "Current directory contents:"
ls -al /projectroot

echo "Send report to Trivy Report Registry..."
curl -X POST -H "Content-Type: application/json" -d @/projectroot/report.json https://trivy-report-registry.ff-hamm.de/incomming-report

echo "Tests successful."
exit 0