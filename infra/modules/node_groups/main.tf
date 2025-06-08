terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_eks_node_group" "stateless" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-stateless"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids


  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  labels = {
    workload = "stateless"
  }

  tags = {
    Name = "${var.cluster_name}-stateless"
  }
}

resource "aws_eks_node_group" "dbproxy" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-dbproxy"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids


  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  labels = {
    workload = "db"
  }

  tags = {
    Name = "${var.cluster_name}-dbproxy"
  }
}

resource "aws_eks_node_group" "batch" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-batch"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids


  scaling_config {
    desired_size = 0
    max_size     = 3
    min_size     = 0
  }

  labels = {
    workload = "batch"
  }

  tags = {
    Name = "${var.cluster_name}-batch"
  }
}
