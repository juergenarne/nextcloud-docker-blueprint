#!/bin/bash

set -e

LOG_FILE="/var/www/html/data/nextcloud.log"

if docker compose exec -T -u www-data app test -f "$LOG_FILE"; then
    docker compose exec -T -u www-data app sh -c ": > '$LOG_FILE'"
    echo "Nextcloud-Log geleert."
else
    echo "Nextcloud-Log nicht gefunden: $LOG_FILE"
    exit 1
fi
