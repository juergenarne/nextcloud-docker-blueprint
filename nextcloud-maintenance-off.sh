#!/bin/bash

docker exec -u www-data pnoom-nextcloud php occ maintenance:mode --off
