# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.0"
  
  name                   = "${local.name_prefix}-BastionHost"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.bastion_host_instance_type
  key_name               = var.bastion_host_key_pair
  
  subnet_id              = module.vpc.public_subnets[0]
  
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = local.tags
  
}

