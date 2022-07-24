locals {

  department = var.department
  environment = var.environment

  name_prefix = "${local.environment}-${local.department}"
  vpc_name = "${local.name_prefix}-eks-vpc"
  eks_cluster_name = "${local.name_prefix}-eks-cluster"

  tags = {
    department = local.department
    environment = local.environment
  }

  vpc_tags = {
      "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
      department = local.department
      environment = local.environment
    }

  vpc_public_subnet_tags = {     
      "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
      "kubernetes.io/role/elb"                          = "1"
      department = local.department
      environment = local.environment
  }

  vpc_private_subnet_tags = {
      "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
      "kubernetes.io/role/internal-elb"                 = "1"
      department = local.department
      environment = local.environment
  }

}