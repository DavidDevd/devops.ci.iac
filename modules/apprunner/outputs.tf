output "service_url" {
  description = "URL do serviço AppRunner"
  value       = aws_apprunner_service.this.service_url
}

output "service_arn" {
  description = "ARN do serviço AppRunner"
  value       = aws_apprunner_service.this.arn
}

output "service_id" {
  description = "ID do serviço AppRunner"
  value       = aws_apprunner_service.this.service_id
}