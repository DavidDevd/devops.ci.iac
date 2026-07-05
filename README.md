# CI/CD Infrastructure With Terraform, ECR and AWS App Runner

Infrastructure as Code project for deploying a containerized FastAPI application to AWS App Runner using Terraform.

This repository is part of a pair:

- Application repository: `DavidDevd/devops.ci.api`
- Infrastructure repository: `DavidDevd/devops.ci.iac`

## What This Project Shows

- Terraform modules for ECR, IAM and App Runner
- Separate `dev` and `prod` environments
- GitHub Actions workflow for infrastructure validation
- AWS IAM/OIDC design for GitHub-based deployments
- Container image deployment through Amazon ECR
- Runtime environment variables managed through Terraform inputs

## Architecture

```text
GitHub Actions
  |
  v
Amazon ECR  ->  AWS App Runner
  |
  v
FastAPI container from devops.ci.api
```

## Repository Structure

```text
envs/
  dev/
  prod/
modules/
  apprunner/
  ecr/
  iam/
.github/
  workflows/
```

## How To Use

Create a local variables file from the example:

```bash
cd envs/dev
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

Repeat the same flow under `envs/prod` for the production environment.

## Security Notes

- Real `.tfvars` files are ignored by Git.
- Only `.tfvars.example` files are committed.
- Terraform state files are ignored and must stay outside the repository.
- AWS credentials should come from AWS CLI profiles, OIDC, or environment variables.

## Related Project

The application deployed by this infrastructure is available at:

https://github.com/DavidDevd/devops.ci.api

