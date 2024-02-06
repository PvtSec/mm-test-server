#!/bin/bash

set -e
clear

docker build -f Dockerfile . -t mm-server
docker run --rm --name mm-server -p 8065:8065 mm-server