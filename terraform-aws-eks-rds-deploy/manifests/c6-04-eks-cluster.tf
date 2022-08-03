module "eks" {

    source  = "terraform-aws-modules/eks/aws"
    version = "18.26.5"
       
    cluster_name    = local.eks_cluster_name
    cluster_version = var.eks_cluster_version

    cluster_endpoint_private_access = true
    cluster_endpoint_public_access  = true

    vpc_id          = module.vpc.vpc_id
    subnet_ids      = module.vpc.private_subnets

    manage_aws_auth_configmap = true
    
    cluster_addons = {
        coredns = {
            resolve_conflicts = "OVERWRITE"
        }

        kube-proxy = {}

        vpc-cni = {
            resolve_conflicts = "OVERWRITE"
        }
    }

    node_security_group_additional_rules = {

        ingress_self_all = {
            description = "Node to node all ports/protocols"
            protocol    = "-1"
            from_port   = 0
            to_port     = 0
            type        = "ingress"
            self        = true
        }
        
        egress_all = {
            description      = "Node all egress"
            protocol         = "-1"
            from_port        = 0
            to_port          = 0
            type             = "egress"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
        }

        control_plane_to_node_all = {
            description = "All traffics from Control plane to Node"
            protocol    = "-1"
            from_port   = 0
            to_port     = 0
            type        = "ingress"
            source_cluster_security_group = true
        }

        /*
        # Resolve the AWS Load Balancer Controller Target Registration Issue
        ingress_allow_access_from_control_plane_1 = {
            type                          = "ingress"
            protocol                      = "tcp"
            from_port                     = 9443
            to_port                       = 9443
            source_cluster_security_group = true
            description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
        }

        # Resolve the Nginx Ingress Controller webhook timeout issue
        ingress_allow_access_from_control_plane_2 = {
            type                          = "ingress"
            protocol                      = "tcp"
            from_port                     = 8443
            to_port                       = 8443
            source_cluster_security_group = true
            description                   = "Allow access from control plane to webhook port of nginx ingress controller"
        }

        # Allow access from control plane to metric server port
        ingress_allow_access_from_control_plane_3 = {
            type                          = "ingress"
            protocol                      = "tcp"
            from_port                     = 4443
            to_port                       = 4443
            source_cluster_security_group = true
            description                   = "Allow access from control plane to metric server port"
        }
        */
    }

    # EKS Managed Node Group(s) default values - Applicable to all nodes
    eks_managed_node_group_defaults = {

        ami_type       = "AL2_x86_64"
        instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]

        # Don't add it, fails with error "expect exactly one securityGroup tagged with kubernetes.io/cluster/stage-tech-eks-cluster"
        #attach_cluster_primary_security_group = true

        # Additional Security Groups to be attached
        vpc_security_group_ids                = [ aws_security_group.all_worker_mgmt.id ]

    }

    eks_managed_node_groups = {

        nodegroup-1 = {

            min_size     = var.eks_min_worker_nodes
            max_size     = var.eks_max_worker_nodes
            desired_size = var.eks_desired_worker_nodes

            instance_types = [var.eks_worker_instance_type]
            capacity_type  = "ON_DEMAND"
            
            block_device_mappings = {
                xvda = {
                    device_name = "/dev/xvda"
                    ebs = {
                        volume_size           = var.eks_worker_root_volume_size
                        volume_type           = var.eks_worker_root_volume_type
                        delete_on_termination = true
                    }
                }
            }

            # Using SSM session manager instead of PEM keys. Adding the arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore policy 
            # to the nodes will allow access via SSM since the SSM agent is installed by default on EKS optimized AMIs.

            iam_role_additional_policies = [ 
                "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
            ]
        }
    }
    
    # Creates OIDC Provider to Enable IRSA (IAM Role for Service Account)
    enable_irsa = true

    # https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
    cluster_enabled_log_types = ["api", "audit","controllerManager","scheduler","authenticator"]

    tags = local.tags

}
