output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_id" {
  value = aws_eks_cluster.this.id
}
