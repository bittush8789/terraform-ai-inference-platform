variable "environment" {
  description = "The environment name"
  type        = string
  default     = "production"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "ai-platform-eks"
}

variable "cluster_role_arn" {
  description = "The IAM Role ARN for EKS cluster control plane"
  type        = string
}

variable "node_role_arn" {
  description = "The IAM Role ARN for EKS worker nodes"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to deploy the cluster into"
  type        = string
}

variable "private_subnet_ids" {
  description = "The private subnets for EKS worker nodes"
  type        = list(string)
}

variable "instance_types" {
  description = "The instance types to use for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}
