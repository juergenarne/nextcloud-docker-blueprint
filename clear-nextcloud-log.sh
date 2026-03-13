#!/bin/bash
# nextcloud-log-clear.sh
# Dieses Skript leert die Nextcloud-Logs

NEXTCLOUD_CONTAINER="pnoom-nextcloud"
DB_CONTAINER="pnoom-db"
DB_TYPE="mysql"  # mysql oder pgsql

# Pfad zur Log-Datei (File-Logging)
LOG_FILE="/var/www/html/data/nextcloud.log"

# Prüfen, ob Log-Datei existiert
docker exec -u www-data $NEXTCLOUD_CONTAINER test -f $LOG_FILE
if [ $? -eq 0 ]; then
    echo "Leere Log-Datei $LOG_FILE..."
    docker exec -u www-data $NEXTCLOUD_CONTAINER sh -c "> $LOG_FILE"
    echo "Fertig!"
else
    echo "Log-Datei nicht gefunden, versuche Datenbank-Logging..."
    if [ "$DB_TYPE" = "mysql" ]; then
        echo "Leere oc_log-Tabelle in MySQL..."
        docker exec -i $DB_CONTAINER mysql -u root -p -e "TRUNCATE TABLE oc_log;"
    elif [ "$DB_TYPE" = "pgsql" ]; then
        echo "Leere oc_log-Tabelle in PostgreSQL..."
        docker exec -i $DB_CONTAINER psql -U postgres -d nextcloud -c "TRUNCATE TABLE oc_log;"
    else
        echo "Unbekannter DB-Typ: $DB_TYPE"
        exit 1
    fi
    echo "Fertig!"
fi
