resource "aws_ecr_repository" "repository" {
  name                 = var.repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
    Application = var.application
  }
}

resource "aws_ecr_lifecycle_policy" "repository_policy" {
  repository = aws_ecr_repository.repository.name

  policy =  jsonencode(
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last ${var.max_images} images",
        "selection": {
          "tagStatus": "any",
          "countType": "imageCountMoreThan",
          "countNumber": var.max_images
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  })
}