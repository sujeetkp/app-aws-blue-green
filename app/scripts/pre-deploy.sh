#!/bin/bash

# Get Kubeconfig
aws eks update-kubeconfig --name ${KUBERNETES_CLUSTER_NAME}

# Delete secret
kubectl delete secret secretdata

# Create required secrets
kubectl create secret generic secretdata \
--from-literal secretkey=${APP_SECRET_KEY}  \
--from-literal emailpassword=${EMAIL_PASSWORD}  \
--from-literal dbpassword=${DB_PASSWORD} \
--from-literal aws_access_key_id=${AWS_ACCESS_KEY_ID} \
--from-literal aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}