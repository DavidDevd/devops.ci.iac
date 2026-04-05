resource "aws_apprunner_service" "this" {
  service_name = "${var.environment}-${var.service_name}"

  source_configuration {
    authentication_configuration {
      access_role_arn = var.app_runner_role_arn
    }

    image_repository {
      image_identifier      = "${var.repository_url}:${var.image_tag}"
      image_repository_type = "ECR"

      image_configuration {
        port = var.app_port

        runtime_environment_variables = var.environment_variables
      }
    }

    auto_deployments_enabled = false
  }

  health_check_configuration {
    protocol            = "HTTP"
    path                = var.health_check_path
    interval            = 10
    timeout             = 5
    healthy_threshold   = 1
    unhealthy_threshold = 3
  }

  instance_configuration {
    cpu    = var.cpu
    memory = var.memory
  }

  tags = {
    IAC = "True"
    Env = var.environment
  }
}