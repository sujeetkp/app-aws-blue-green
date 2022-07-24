# List of Availability Zones
data "aws_availability_zones" "azs" {
  filter {
      name   = "opt-in-status"
      values = ["opt-in-not-required"]
    }
}

# Create VPC for EKS
module "vpc" {
    
    source  = "terraform-aws-modules/vpc/aws"
    version = "3.14.2"
  
    name = local.vpc_name
    cidr = var.vpc_cidr_block

    azs                 = data.aws_availability_zones.azs.names
    private_subnets     = var.vpc_private_subnets
    public_subnets      = var.vpc_public_subnets
    database_subnets    = var.vpc_database_subnets

    enable_dns_hostnames = true

    enable_nat_gateway = true
    single_nat_gateway = var.vpc_single_nat_gateway
    
    create_database_subnet_group = true

    # Mandatory Tags for EKS Cluster VPC
    tags = local.vpc_tags
    public_subnet_tags = local.vpc_public_subnet_tags
    private_subnet_tags = local.vpc_private_subnet_tags
}