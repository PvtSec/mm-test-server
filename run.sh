#!/bin/bash

set -e
clear

docker build -f Dockerfile . -t mm-server
docker run --rm --name mm-server -p 808:8080 mm-server