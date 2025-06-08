output "eks_node_sg_id" {
  value = aws_security_group.eks_nodes.id
}

output "ssm_endpoints_sg_id" {
  value = aws_security_group.ssm_endpoints_sg.id
}

output "worker_node_sg_id" {
  value = aws_security_group.eks_nodes.id
}
