#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Step 1:
# Create dockerpath
dockerpath=danielsiefert/devops-capstone

# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login --username=danielsiefert

# Step 3:
# Push image to a docker repository
docker push $dockerpath:latest
