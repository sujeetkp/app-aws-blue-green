#!/bin/bash

# Deploy EKS Cluster
terraform -chdir=$CHDIR init -input=false -backend-config=backend.conf
terraform -chdir=$CHDIR validate
terraform -chdir=$CHDIR plan -input=false -lock=false -var-file=config.tfvars -var-file=secret.tfvars

terraform -chdir=$CHDIR apply -input=false -var-file=config.tfvars -var-file=secret.tfvars -auto-approve