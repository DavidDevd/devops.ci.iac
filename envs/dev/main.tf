module "ecr" {
  source = "../../modules/ecr"

  repository_name = "${var.environment}-davops-api"
  environment     = var.environment
}

module "iam" {
  source = "../../modules/iam"

  environment = var.environment
  github_org  = var.github_org
  github_repo = var.github_repo
}

module "apprunner" {
  source = "../../modules/apprunner"

  environment           = var.environment
  service_name          = var.service_name
  repository_url        = module.ecr.repository_url
  image_tag             = var.image_tag
  app_runner_role_arn   = module.iam.app_runner_role_arn
  environment_variables = var.environment_variables

  depends_on = [module.ecr, module.iam]
}