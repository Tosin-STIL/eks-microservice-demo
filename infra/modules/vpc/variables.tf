variable "region" {
  description = "AWS region to deploy VPC"
  type        = string
}
variable "cluster_name" {
  description = "EKS cluster name for tagging"
  type        = string
}

variable "ssm_endpoint_sg_id" {
  description = "Security group ID for VPC interface endpoints"
  type        = string
}
