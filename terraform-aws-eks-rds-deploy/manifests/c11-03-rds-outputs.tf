# aws_rds_cluster
output "cluster_arns" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = { for key, instance in module.aurora : key => instance.cluster_arn }
}

output "cluster_ids" {
  description = "The RDS Cluster Identifier"
  value       = { for key, instance in module.aurora : key => instance.cluster_id }
}

output "cluster_resource_ids" {
  description = "The RDS Cluster Resource ID"
  value       = { for key, instance in module.aurora : key => instance.cluster_resource_id }
}

output "cluster_write_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = { for key, instance in module.aurora : key => instance.cluster_endpoint }
}

output "cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = { for key, instance in module.aurora : key => instance.cluster_reader_endpoint }
}

# aws_security_group
output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = { for key, instance in module.aurora : key => instance.security_group_id }
}