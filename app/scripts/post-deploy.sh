#!/bin/bash

#sleep 300

echo 'Kubernetes Nodes ...'
kubectl get nodes

echo 'Kubernetes secret ...'
kubectl get secret

echo 'Kubernetes deployments ...'
kubectl get deploy

echo 'Kubernetes Pods ...'
kubectl get pods

echo 'Kubernetes Services ...'
kubectl get svc

echo 'Kubernetes hpa ...'
kubectl get hpa

echo 'Kubernetes ingress ...'
kubectl get ingresses

echo 'Kubernetes Service Monitor ...'
kubectl get servicemonitor

echo 'Kubernetes apiservices ...'
kubectl get apiservice

echo 'Installed helm charts ...'
helm list --all-namespaces

echo 'List all helm values'
helm get values --all ${HELM_RELEASE_NAME}