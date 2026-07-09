variable "environment" {
  description = "The environment name"
  type        = string
  default     = "production"
}

variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "ai-inference-app"
}
