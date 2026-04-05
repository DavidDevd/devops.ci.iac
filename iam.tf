resource "aws_iam_openid_connect_provider" "oidc-git" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "2b18947a6a9fc7764fd8b5fb18a863b0c6dac24f"
  ]

  tags = {
    IAC = "True"
  }
}

resource "aws_iam_role" "tf-role" {
  name = "tf-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : aws_iam_openid_connect_provider.oidc-git.arn
        },
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : ["sts.amazonaws.com"]
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : [
              "repo:DavidDevd/devops.ci.iac:ref:refs/heads/main"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "app-runner-role" {
  name = "app-runner-role"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect    : "Allow",
        Principal : { Service : "build.apprunner.amazonaws.com" },
        Action    : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    IAC = "True"
  }
}

resource "aws_iam_role_policy_attachment" "app-runner-ecr-policy" {
  role       = aws_iam_role.app-runner-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role" "ecr-role" {
  name = "ecr-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : aws_iam_openid_connect_provider.oidc-git.arn
        },
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : ["sts.amazonaws.com"]
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : [
              "repo:DavidDevd/devops.ci.api:ref:refs/heads/main"
            ]
          }
        }
      }
    ]
  })

  tags = {
    IAC = "True"
  }
}

resource "aws_iam_role_policy" "ecr-app-permission" {
  name = "ecr-app-permission"
  role = aws_iam_role.ecr-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AppRunnerActions1"
        Effect   = "Allow"
        Action   = "apprunner:*"
        Resource = "*"
      },
      {
        Sid    = "AppRunnerActions2"
        Effect = "Allow"
        Action = [
          "iam:PassRole",
          "iam:CreateServiceLinkedRole"
        ]
        Resource = "*"
      },
      {
        Sid    = "ECRImageActions3"
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
        Resource = "*"
      },
      {
        Sid      = "ECRAuthToken"
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      }
    ]
  })
}