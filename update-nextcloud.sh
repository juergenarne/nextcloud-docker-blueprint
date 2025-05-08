#!/bin/bash
docker exec -u www-data pnoom-nextcloud php occ maintenance:mode --on
docker exec -u www-data pnoom-nextcloud php occ upgrade
docker exec -u www-data pnoom-nextcloud php occ maintenance:mode --off