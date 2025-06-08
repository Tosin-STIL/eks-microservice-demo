# C:\Users\tjesc\eks-microservice-demo\infra\backend.tf

terraform {
  backend "s3" {
    bucket         = "finbankops-terraform-state"
    key            = "multi-region/eks.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "finbankops-terraform-locks"
    encrypt        = true
  }
}
