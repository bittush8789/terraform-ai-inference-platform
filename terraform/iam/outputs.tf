output "cluster_role_arn" {
  description = "The ARN of the EKS Cluster role"
  value       = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  description = "The ARN of the EKS node group role"
  value       = aws_iam_role.node.arn
}

output "aws_lbc_role_arn" {
  description = "The ARN of the AWS Load Balancer Controller IAM role"
  value       = aws_iam_role.aws_lbc.arn
}
