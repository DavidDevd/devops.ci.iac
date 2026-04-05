variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Ambiente"
  type        = string
  default     = "prod"
}

variable "github_org" {
  description = "Organização ou usuário do GitHub"
  type        = string
}

variable "github_repo" {
  description = "Repositório da aplicação no GitHub"
  type        = string
}

variable "service_name" {
  description = "Nome do serviço"
  type        = string
}

variable "image_tag" {
  description = "Tag da imagem Docker"
  type        = string
  default     = "latest"
}

variable "environment_variables" {
  description = "Variáveis de ambiente da aplicação"
  type        = map(string)
  default     = {}
}