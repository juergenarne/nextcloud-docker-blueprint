#!/bin/bash

docker exec -u www-data -it pnoom-nextcloud php occ db:add-missing-indices
