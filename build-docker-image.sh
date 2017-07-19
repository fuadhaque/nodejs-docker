#!/bin/bash
# --rm=true will remove intermediate images
docker build -t 192.168.56.101:5000/test-nodejs:latest --rm=true .
