#!/bin/bash

docker run --rm ${ECR_CONTAINER_REGISTRY}/blog:${SHA}  echo 'App built successfully'


