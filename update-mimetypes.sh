#!/bin/bash

docker exec -u www-data -it pnoom-nextcloud php occ maintenance:repair --include-expensive
