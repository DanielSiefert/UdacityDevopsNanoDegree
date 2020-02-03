#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
dockerpath=danielsiefert/devops-capstone
docker build --tag $dockerpath .

# Step 2: 
# List docker images
docker images $dockerpath

# Step 3: 
# Run the container
docker run -p 127.0.0.1:8080:80 $dockerpath
