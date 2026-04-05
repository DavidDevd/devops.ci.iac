variable "environment" {
  description = "Ambiente (dev ou prod)"
  type        = string
}

variable "github_org" {
  description = "Organização ou usuário do GitHub"
  type        = string
}

variable "github_repo" {
  description = "Nome do repositório da aplicação no GitHub"
  type        = string
}