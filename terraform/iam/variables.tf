variable "environment" {
  description = "The environment name"
  type        = string
  default     = "production"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "oidc_provider_url" {
  description = "The OIDC provider URL from EKS"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The OIDC provider ARN from EKS"
  type        = string
}
