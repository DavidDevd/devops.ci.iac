variable "repository_name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev ou prod)"
  type        = string
}