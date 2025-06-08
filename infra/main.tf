module "vpc_us_east" {
  source             = "./modules/vpc"
  region             = "us-east-1"
  cluster_name       = "eks-us-east-1"
  ssm_endpoint_sg_id = module.security_us_east.ssm_endpoints_sg_id

  providers = {
    aws = aws.us_east
  }
}

module "vpc_us_west" {
  source             = "./modules/vpc"
  region             = "us-west-2"
  cluster_name       = "eks-us-west-2"
  ssm_endpoint_sg_id = module.security_us_west.ssm_endpoints_sg_id

  providers = {
    aws = aws.us_west
  }
}

module "iam_us_east" {
  source = "./modules/iam"
  region = "us-east-1"

  providers = {
    aws = aws.us_east
  }
}

module "iam_us_west" {
  source = "./modules/iam"
  region = "us-west-2"

  providers = {
    aws = aws.us_west
  }
}

module "security_us_east" {
  source       = "./modules/security"
  vpc_id       = module.vpc_us_east.vpc_id
  region       = "us-east-1"
  cluster_name = "eks-us-east-1"

  providers = {
    aws = aws.us_east
  }
}

module "security_us_west" {
  source       = "./modules/security"
  vpc_id       = module.vpc_us_west.vpc_id
  region       = "us-west-2"
  cluster_name = "eks-us-west-2"

  providers = {
    aws = aws.us_west
  }
}

module "eks_us_east" {
  source           = "./modules/eks"
  region           = "us-east-1"
  vpc_id           = module.vpc_us_east.vpc_id
  subnets          = module.vpc_us_east.private_subnets
  cluster_role_arn = module.iam_us_east.eks_cluster_role_arn

  providers = {
    aws = aws.us_east
  }
}

module "eks_us_west" {
  source           = "./modules/eks"
  region           = "us-west-2"
  vpc_id           = module.vpc_us_west.vpc_id
  subnets          = module.vpc_us_west.private_subnets
  cluster_role_arn = module.iam_us_west.eks_cluster_role_arn

  providers = {
    aws = aws.us_west
  }
}

module "node_groups_us_east" {
  source        = "./modules/node_groups"
  region        = "us-east-1"
  cluster_name  = module.eks_us_east.cluster_name
  subnet_ids    = module.vpc_us_east.private_subnets
  node_role_arn = module.iam_us_east.node_role_arn

  providers = {
    aws = aws.us_east
  }
}

module "node_groups_us_west" {
  source        = "./modules/node_groups"
  region        = "us-west-2"
  cluster_name  = module.eks_us_west.cluster_name
  subnet_ids    = module.vpc_us_west.private_subnets
  node_role_arn = module.iam_us_west.node_role_arn

  providers = {
    aws = aws.us_west
  }
}
