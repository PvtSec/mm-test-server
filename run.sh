#!/bin/bash

set -e
clear

docker kill mm-server || true
docker rm mm-server || true

docker build -f Dockerfile . -t mm-server
docker run --rm --name mm-server -p 17777:8080 mm-server
