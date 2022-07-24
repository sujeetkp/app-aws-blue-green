#!/bin/bash

#export KUBECONFIG=./manifests/kubeconfig/kubeconfig
echo $KUBECONFIG

echo 'Kubernetes Nodes ...'
kubectl get nodes

echo 'Kubernetes Pods ...'
kubectl get pods --all-namespaces

echo 'Installed helm charts ...'
helm list