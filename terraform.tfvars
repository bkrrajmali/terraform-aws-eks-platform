region = "us-east-1"
tags = {
  project = "demoeks"
}

ecr_repository_name = "demoeks"

cluster_name = "demoeks"

# Control plane version. Upgrade ONE minor version at a time (1.35 -> 1.36 -> 1.37).
kubernetes_version = "1.36"

# Worker node version. Same as the control plane, or up to 2 behind it.
# Can jump straight to the target once the control plane is there (1.35 -> 1.37).
node_kubernetes_version = "1.35"

enable_oidc = true

# Add your own IAM user/role ARN here so you can run kubectl.
admin_principal_arns = []

vpc_name        = "eks-vpc"
vpc_cidr        = "10.0.0.0/16"
private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

system_node_group = {
  name           = "system"
  instance_types = ["t3.medium"]
  min_size       = 1
  max_size       = 3
  desired_size   = 1
  disk_size      = 30
}

user_node_group = {
  name           = "user"
  instance_types = ["t3.medium"]
  min_size       = 1
  max_size       = 3
  desired_size   = 1
  disk_size      = 30
}
