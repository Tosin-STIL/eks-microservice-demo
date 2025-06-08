variable "home_region" {
  description = "Region for state and global resources"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_regions" {
  description = "Regions to deploy clusters"
  type        = list(string)
  default     = ["us-east-1", "us-west-2"]
}


