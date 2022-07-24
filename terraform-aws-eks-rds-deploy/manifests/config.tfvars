# Global Variables
aws_region = "us-east-1"
department = "tech"
environment = "stage"

# VPC Variables
vpc_cidr_block = "10.0.0.0/16"
vpc_public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
vpc_database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]
vpc_single_nat_gateway = true

# EKS Cluster Variables
eks_cluster_version = "1.22"
eks_desired_worker_nodes = 2
eks_max_worker_nodes = 2
eks_min_worker_nodes = 2
eks_worker_instance_type = "t3.medium"
eks_worker_root_volume_size = "10"
eks_worker_key_pair = "us-east-1-kp"
eks_worker_root_volume_type = "gp2"

# Bastion Host
bastion_host_instance_type = "t2.micro"
bastion_host_key_pair = "us-east-1-kp"

# IAM Policy and Roles form AWS LB Controller, Cert Manager and External DNS
iam_policy_name        = "AllowExternalDNSUpdates"
iam_role_cert_manager  = "cert-manager"
iam_role_external_dns  = "external-dns"
cert_manager_namespace = "cert-manager"
external_dns_namespace = "default"
aws_lb_iam_policy_name = "AWSLoadBalancerControllerIAMPolicy"
iam_role_aws_lb        = "AmazonEKSLoadBalancerControllerRole"
aws_lb_namespace       = "kube-system"
aws_lb_service_account = "aws-load-balancer-controller"

# External DNS Domain
aws_hosted_zone_name = "simplifydev.co"

# RDS Aurora Postgres Database Parameters
rds_engine = "aurora-postgresql"
rds_engine_version = "13.6"
rds_instance_class = "db.t3.medium"
rds_db_name = "postgres"
rds_db_username = "postgres"
rds_db_port = 5432
