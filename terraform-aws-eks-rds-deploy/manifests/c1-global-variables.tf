variable "aws_region" {
  type = string
  description = "AWS Region"
}

variable "department" {
  type = string
  description = "Department"
}

variable "environment" {
  type = string
  description = "Environment"
}

# Policy and Role Details

variable "iam_policy_name" {
  type = string
  description = "IAM Policy Name for Cert Manager and ExternalDNS"
}

variable "iam_role_cert_manager" {
  type = string
  description = "IAM Role for Cert Manager"
}

variable "cert_manager_namespace" {
  type = string
  description = "Cert Manager namespace"
}

variable "iam_role_external_dns" {
  type = string
  description = "IAM Role for External DNS"
}

variable "external_dns_namespace" {
  type = string
  description = "External DNS namespace"
}

variable "aws_hosted_zone_name" {
  type = string
  description = "AWS Hosted Zone for External DNS to Monitor"
}

variable "aws_lb_iam_policy_name" {
  type = string
  description = "IAM Policy Name for AWS LB Controller"
}

variable "iam_role_aws_lb" {
  type = string
  description = "IAM Role for AWS LB Controller"
}

variable "aws_lb_namespace" {
  type = string
  description = "AWS LB Controller namespace"
}

variable "aws_lb_service_account" {
  type = string
  description = "AWS LB Controller service account name"
}