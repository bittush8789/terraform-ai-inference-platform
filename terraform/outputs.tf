output "cluster_name" {
  description = "The EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "The EKS Cluster Control Plane Endpoint"
  value       = module.eks.cluster_endpoint
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "vpc_id" {
  description = "The VPC ID"
  value       = module.networking.vpc_id
}
