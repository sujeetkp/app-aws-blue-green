
variable "eks_cluster_version" {
  type = string
  description = "EKS Cluster Version"
}

variable "eks_desired_worker_nodes" {
  type = number
  description = "Number of Worker Nodes"
}

variable "eks_max_worker_nodes" {
  type = number
  description = "Number of Worker Nodes"
}

variable "eks_min_worker_nodes" {
  type = number
  description = "Number of Worker Nodes"
}

variable "eks_worker_instance_type" {
  type = string
  description = "EKS Worker Instance Type"
}

variable "eks_worker_root_volume_size" {
  type = number
  description = "EKS Worker Root Volume Size"
}

variable "eks_worker_root_volume_type" {
  type = string
  description = "EKS Worker Root Volume type"
}

variable "eks_worker_key_pair" {
  type = string
  description = "EKS Worker Key Pair"
}

