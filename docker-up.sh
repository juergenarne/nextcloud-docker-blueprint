#!/bin/bash
echo "Stopping all containers."
docker stop $(docker ps -a -q) &> /dev/null
echo "Deleting all stopped containers."
docker rm -f $(docker ps -a -q -f status=exited) &> /dev/null
docker rm -f $(docker ps -a -q -f status=dead) &> /dev/null
echo "Starting environment."
docker compose up -d