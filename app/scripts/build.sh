#!/bin/bash

# Print Jenkins Build Number and Git SHA
echo "Jenkins Build No.: ${BUILD_NUMBER}"
echo "GIT Commit: ${GIT_COMMIT}"

#SHA=$(git rev-parse --short=4 ${GIT_COMMIT})
echo "GIT SHA.: ${SHA}"

# Build Image
sudo docker build -t ${ECR_CONTAINER_REGISTRY}/blog:${SHA} ./blog

