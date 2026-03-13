#!/bin/bash
set -e

docker compose pull app
docker compose up -d --force-recreate app

docker compose exec -u www-data app php occ upgrade
docker compose exec -u www-data app php occ maintenance:repair --include-expensive
docker compose exec -u www-data app php occ db:add-missing-indices
docker compose exec -u www-data app php occ db:add-missing-columns
docker compose exec -u www-data app php occ db:add-missing-primary-keys
docker compose exec -u www-data app php occ status
