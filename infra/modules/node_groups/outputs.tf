output "nodegroup_names" {
  value = [
    aws_eks_node_group.stateless.node_group_name,
    aws_eks_node_group.dbproxy.node_group_name,
    aws_eks_node_group.batch.node_group_name
  ]
}
