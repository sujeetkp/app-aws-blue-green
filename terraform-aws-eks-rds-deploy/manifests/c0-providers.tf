terraform {
  required_version = "~> 1.2.2"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.22.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.12.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.6.0"
    }
    tls = {
      version = "<4.0.0"
    }
  }

  #Configuration To be picked from Config file
  backend "s3" {}
  
}

provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}