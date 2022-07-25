#!/bin/bash

# Login to ECR
aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${ECR_CONTAINER_REGISTRY}

# Push Image to ECR
docker push ${ECR_CONTAINER_REGISTRY}/blog:${SHA} 


