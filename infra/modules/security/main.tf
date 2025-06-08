terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_security_group" "eks_nodes" {
  name        = "eks-nodes-sg-${var.region}"
  description = "Allow worker nodes to communicate"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # You can tighten this for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-sg-${var.region}"
  }
}

resource "aws_security_group" "ssm_endpoints_sg" {
  name        = "ssm-endpoints-sg-${var.region}"
  description = "Security group for VPC Interface Endpoints (SSM, EC2Messages)"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS from private subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Adjust to your VPC CIDR range if different
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssm-endpoints-sg-${var.region}"
  }
}
