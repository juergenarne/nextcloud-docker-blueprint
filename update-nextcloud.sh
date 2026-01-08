#!/bin/bash
docker compose down -v --remove-orphans
docker pull nextcloud:latest
docker compose up -d --build
sleep 10
# docker exec -u www-data pnoom-nextcloud php occ maintenance:mode --on
docker exec -u www-data pnoom-nextcloud php occ upgrade
docker exec -u www-data pnoom-nextcloud php occ maintenance:repair --include-expensive
docker exec -u www-data pnoom-nextcloud php occ db:add-missing-indices
# docker exec -u www-data pnoom-nextcloud php occ maintenance:mode --off
docker exec -u www-data pnoom-nextcloud php occ status
