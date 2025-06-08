variable "vpc_id" {
  description = "VPC to associate security groups with"
  type        = string
}

variable "region" {
  description = "Region label for naming"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster for resource tagging"
  type        = string
}
