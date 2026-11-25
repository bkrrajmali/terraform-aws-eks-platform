###############################################################################
# Network
###############################################################################

output "region" {
  value = var.region
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = module.vpc.vpc_name
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

###############################################################################
# EKS
###############################################################################

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_role_arn" {
  value = module.eks.node_role_arn
}

output "oidc_issuer_url" {
  value = module.eks.oidc_issuer_url
}

output "oidc_provider_arn" {
  description = "For IRSA roles (the AWS equivalent of AKS workload identity)."
  value       = module.eks.oidc_provider_arn
}

output "configure_kubectl" {
  description = "Run this to point kubectl at the cluster."
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}

###############################################################################
# ECR
###############################################################################

output "ecr_arn" {
  value = module.ecr.ecr_arn
}

output "ecr_repository_url" {
  description = "Prefix image tags with this."
  value       = module.ecr.repository_url
}
