#!/bin/bash

AWS_REGION=$(cat manifests/config.tfvars | grep aws_region | cut -d"=" -f2 | sed 's/[\" ]//g')
CLUSTER_NAME="stage-tech-eks-cluster" # We can get this value from terraform output as well.

aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME

echo 'Kubernetes Nodes ...'
kubectl get nodes

echo 'Kubernetes Pods ...'
kubectl get pods --all-namespaces

echo 'Installed helm charts ...'
helm list --all-namespaces