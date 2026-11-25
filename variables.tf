###############################################################################
# Shared
###############################################################################

variable "region" {
  description = "AWS region for all resources."
  type        = string
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}

###############################################################################
# ECR
###############################################################################

variable "ecr_repository_name" {
  description = "ECR repository name (lowercase)."
  type        = string
}

###############################################################################
# Network
###############################################################################

variable "vpc_name" {
  description = "VPC name."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
  type        = string
}

variable "private_subnets" {
  description = "Private subnet CIDRs, one per AZ. Nodes run here."
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDRs, one per AZ. NAT gateway and internet-facing load balancers."
  type        = list(string)
}

###############################################################################
# EKS cluster
###############################################################################

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version, e.g. 1.35."
  type        = string
}

variable "enable_oidc" {
  description = "Create the IAM OIDC provider (IRSA, the AWS version of workload identity)."
  type        = bool
  default     = true
}

variable "admin_principal_arns" {
  description = "IAM user/role ARNs that get cluster admin (kubectl) access."
  type        = list(string)
  default     = []
}

###############################################################################
# Node groups
###############################################################################

variable "system_node_group" {
  description = "Node group for system workloads."
  type = object({
    name           = string
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = number
  })

  validation {
    condition     = var.system_node_group.min_size <= var.system_node_group.desired_size && var.system_node_group.desired_size <= var.system_node_group.max_size
    error_message = "system_node_group must satisfy min_size <= desired_size <= max_size."
  }
}

variable "user_node_group" {
  description = "Node group for application workloads."
  type = object({
    name           = string
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = number
  })

  validation {
    condition     = var.user_node_group.min_size <= var.user_node_group.desired_size && var.user_node_group.desired_size <= var.user_node_group.max_size
    error_message = "user_node_group must satisfy min_size <= desired_size <= max_size."
  }
}
