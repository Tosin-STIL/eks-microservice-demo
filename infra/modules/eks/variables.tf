variable "region" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}
