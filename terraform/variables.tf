variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "production"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "ai-platform-eks"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_types" {
  description = "Worker node instance type"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "repository_name" {
  description = "ECR Repository Name"
  type        = string
  default     = "ai-inference-app"
}
