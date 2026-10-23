data "aws_iam_policy_document" "github_ssm_deploy" {
  # Read-only lookup of the instance. AWS does not allow scoping this action.
  statement {
    sid       = "FindInstance"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }

  # Run commands ONLY on our instance, using ONLY the shell-script document
  statement {
    sid     = "SendCommandToAppInstance"
    actions = ["ssm:SendCommand"]
    resources = [
      "arn:aws:ssm:${var.aws_region}::document/AWS-RunShellScript",
      aws_instance.app.arn,
    ]
  }

  # Read command results
  statement {
    sid       = "ReadCommandResult"
    actions   = ["ssm:GetCommandInvocation", "ssm:ListCommandInvocations"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "github_ssm_deploy" {
  name   = "ssm-deploy"
  role   = aws_iam_role.github_deploy.id
  policy = data.aws_iam_policy_document.github_ssm_deploy.json
}