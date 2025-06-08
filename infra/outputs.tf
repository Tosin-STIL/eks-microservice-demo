output "eks_clusters" {
  value = {
    us_east = module.eks_us_east.cluster_name
    us_west = module.eks_us_west.cluster_name
  }
}

output "node_groups" {
  value = {
    us_east = module.node_groups_us_east.nodegroup_names
    us_west = module.node_groups_us_west.nodegroup_names
  }
}

output "vpc_ids" {
  value = {
    us_east = module.vpc_us_east.vpc_id
    us_west = module.vpc_us_west.vpc_id
  }
}

output "us_east_node_role" {
  value = module.iam_us_east.node_role_arn
}

output "us_east_cluster_role" {
  value = module.iam_us_east.eks_cluster_role_arn
}
