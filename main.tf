###############################################################################
# Modules live in github.com/bkrrajmali/aws-eks-modules
# (same pattern as TerraformAKS -> azure-aks-modules)
###############################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "git::https://github.com/bkrrajmali/aws-eks-modules.git//modules/vpc?ref=main"

  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  azs             = slice(data.aws_availability_zones.available.names, 0, length(var.private_subnets))
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = var.tags
}

module "ecr" {
  source = "git::https://github.com/bkrrajmali/aws-eks-modules.git//modules/ecr?ref=main"

  name = var.ecr_repository_name
  tags = var.tags
}

module "eks" {
  source = "git::https://github.com/bkrrajmali/aws-eks-modules.git//modules/eks?ref=main"

  cluster_name            = var.cluster_name
  kubernetes_version      = var.kubernetes_version
  node_kubernetes_version = var.node_kubernetes_version
  subnet_ids              = module.vpc.private_subnet_ids

  system_node_group = var.system_node_group
  user_node_group   = var.user_node_group

  enable_oidc          = var.enable_oidc
  admin_principal_arns = var.admin_principal_arns

  tags = var.tags
}

