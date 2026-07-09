variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "production"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}
