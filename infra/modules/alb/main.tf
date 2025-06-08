terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_iam_policy" "alb_controller_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy-${var.region}"
  description = "Policy for ALB controller"
  policy      = file("${path.module}/iam-policy.json")

  tags = {
    Name        = "alb-controller-policy-${var.region}"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_role" "alb_controller_role" {
  name = "alb-controller-role-${var.region}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "alb-controller-role-${var.region}"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.alb_controller_role.name
  policy_arn = aws_iam_policy.alb_controller_policy.arn
}
