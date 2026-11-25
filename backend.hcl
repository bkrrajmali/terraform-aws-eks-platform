bucket       = "demoeks-tfstate-demo-bucket"
key          = "eks/terraform.tfstate"
region       = "us-east-1"
encrypt      = true
use_lockfile = true # S3 native locking, no DynamoDB table needed
