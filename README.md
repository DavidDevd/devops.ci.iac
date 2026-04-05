# devops.ci.iac 🏗️

Infraestrutura como código (IaC) para provisionamento dos ambientes **dev** e **prod** 
no AWS AppRunner utilizando Terraform.


## Estrutura


devops.ci.iac/
├── modules/
│   ├── ecr/          # Repositório de imagens Docker
│   ├── iam/          # Roles e políticas de acesso
│   └── apprunner/    # Serviço de execução da aplicação
├── envs/
│   ├── dev/          # Ambiente de desenvolvimento
│   └── prod/         # Ambiente de produção
└── .github/
└── workflows/
└── terraform.yml


## Pré-requisitos

- Terraform >= 1.8.4
- AWS CLI configurado
- Bucket S3 `davops-terraform-state` criado
- Role `tf-role` criada manualmente na AWS

## Como usar localmente
```bash
# Ambiente dev
cd envs/dev
terraform init
terraform plan
terraform apply

# Ambiente prod
cd envs/prod
terraform init
terraform plan
terraform apply
```

## Ambientes

| Ambiente | Branch | State |
|----------|--------|-------|
| dev | main | envs/dev/terraform.tfstate |
| prod | main | envs/prod/terraform.tfstate |

## Recursos provisionados

- **ECR** — Repositório de imagens Docker por ambiente
- **IAM** — OIDC Provider, roles e políticas
- **AppRunner** — Serviço de execução da aplicação