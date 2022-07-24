#!/bin/bash

# Destroy EKS Cluster
terraform -chdir=$CHDIR init -input=false -backend-config=backend.conf
terraform -chdir=$CHDIR destroy -input=false -var-file=config.tfvars -var-file=secret.tfvars -auto-approve