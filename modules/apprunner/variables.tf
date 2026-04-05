variable "environment" {
  description = "Ambiente (dev ou prod)"
  type        = string
}

variable "service_name" {
  description = "Nome do serviço AppRunner"
  type        = string
}

variable "repository_url" {
  description = "URL do repositório ECR"
  type        = string
}

variable "image_tag" {
  description = "Tag da imagem Docker"
  type        = string
  default     = "latest"
}

variable "app_runner_role_arn" {
  description = "ARN da role do AppRunner para acessar o ECR"
  type        = string
}

variable "app_port" {
  description = "Porta da aplicação"
  type        = string
  default     = "8000"
}

variable "environment_variables" {
  description = "Variáveis de ambiente da aplicação"
  type        = map(string)
  default     = {}
}

variable "health_check_path" {
  description = "Endpoint para health check"
  type        = string
  default     = "/health"
}

variable "cpu" {
  description = "CPU do AppRunner (256, 512, 1024, 2048, 4096)"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memória do AppRunner (512, 1024, 2048, 3072, 4096)"
  type        = string
  default     = "512"
}