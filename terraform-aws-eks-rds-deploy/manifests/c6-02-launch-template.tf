/*
data "template_file" "launch_template_userdata" {
  template = file("${path.module}/templates/userdata.sh.tpl")

  vars = {
      cluster_name        = local.eks_cluster_name
      endpoint            = module.eks.cluster_endpoint
      cluster_auth_base64 = module.eks.cluster_certificate_authority_data

      bootstrap_extra_args = ""
      kubelet_extra_args = ""
    }
}
*/

# Launch Template Resource
resource "aws_launch_template" "eks_launch_template" {
  
  name = "${local.name_prefix}-eks-launch-template"
  description = "EKS Launch Template"
  
  # If Launch Template Details are updated, Terraform automatically creates a new version.
  update_default_version = true

  # Root Volume
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {   
      volume_size = var.eks_worker_root_volume_size
      volume_type = var.eks_worker_root_volume_type
      delete_on_termination = true
    }
  }

  ebs_optimized = true

  # Default AMI to be picked for EKS Nodes as Part of Node Group Creation (AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64)
  # If you choose to pass a Custom AMI, then you need to pass bootstrap script as userdata.
  #image_id = data.aws_ami.amzlinux2.id

  # Instance type should be passed along with node groups
  #instance_type = var.eks_worker_instance_type 
  
  key_name = var.eks_worker_key_pair  

  #user_data = base64encode(data.template_file.launch_template_userdata.rendered)
  
  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    
    # Don't use this !! This replaces all the existing security groups.
    #security_groups             = [aws_security_group.all_worker_mgmt.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = local.tags
  }
}
