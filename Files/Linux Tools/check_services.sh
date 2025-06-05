#!/bin/bash

SERVICES=("ssh" "apache2" "networking" "cron")

echo "====== SERVICE STATUS ======"
for service in "${SERVICES[@]}"
do
    echo "Checking $service..."
    systemctl is-active --quiet $service && echo "$service is running." || echo "$service is NOT running."
done
