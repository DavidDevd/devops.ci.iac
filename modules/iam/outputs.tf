output "ecr_role_arn" {
  description = "ARN da role que o GitHub Actions assume para deploy"
  value       = aws_iam_role.ecr-role.arn
}

output "app_runner_role_arn" {
  description = "ARN da role do AppRunner"
  value       = aws_iam_role.app-runner-role.arn
}

output "oidc_provider_arn" {
  description = "ARN do OIDC Provider do GitHub"
  value       = aws_iam_openid_connect_provider.github.arn
}