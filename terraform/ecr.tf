resource "aws_ecr_repository" "app" {
  #checkov:skip=CKV_AWS_51:Images are tagged with the commit SHA, and immutable tags would make a re-run on the same commit fail
  #checkov:skip=CKV_AWS_136:Default AES-256 encryption is on, and a customer-managed key adds cost with no benefit here
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.project_name}-ecr"
  }
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the last 5 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}