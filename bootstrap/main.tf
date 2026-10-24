terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

variable "state_bucket_name" {
  description = "Globally unique name for the Terraform state bucket"
  type        = string
}

variable "github_repo" {
  description = "GitHub repo (owner/name) allowed to assume the plan role"
  type        = string
  default     = "hemanth2k5-png/dockerized-app-aws-terraform-cicd"
}

# --- State bucket ---
resource "aws_s3_bucket" "state" {
  #checkov:skip=CKV2_AWS_62:No consumers for bucket events in this project
  #checkov:skip=CKV_AWS_18:Access logging needs a second bucket, and versioning already records every state change
  #checkov:skip=CKV_AWS_144:Cross-region replication adds cost and a second bucket, and versioning covers overwrites
  #checkov:skip=CKV_AWS_145:The bucket uses SSE-S3 (AES-256), and a customer-managed KMS key adds cost for no benefit here
  bucket = var.state_bucket_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket                  = aws_s3_bucket.state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# --- GitHub OIDC provider (moved here from the main stack) ---
resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

# --- Read-only role used by the pull request plan ---
data "aws_iam_policy_document" "plan_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.github_repo}:pull_request",
        "repo:hemanth2k5-png@232191376/dockerized-app-aws-terraform-cicd@1410780692:pull_request",
      ]
    }
  }
}

resource "aws_iam_role" "github_plan" {
  name               = "github-actions-plan"
  assume_role_policy = data.aws_iam_policy_document.plan_trust.json
}

resource "aws_iam_role_policy_attachment" "plan_readonly" {
  role       = aws_iam_role.github_plan.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

output "state_bucket" {
  value = aws_s3_bucket.state.id
}

output "plan_role_arn" {
  value = aws_iam_role.github_plan.arn
}

resource "aws_s3_bucket_lifecycle_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    id     = "expire-old-state-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }

  depends_on = [aws_s3_bucket_versioning.state]
}