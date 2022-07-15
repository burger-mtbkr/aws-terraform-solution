# IAM Role Creation with Policies
# Examples: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

data "aws_iam_policy_document" "jogday_iam_role_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "log_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "logs:*",
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "sns_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "sns:*",
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "sqs_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:*"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "lambda:*"
    ]
    resources = [
      "*"
    ]
  }
}


data "aws_iam_policy_document" "kms_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role" "jogday_iam_role" {
  name               = var.jogday_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.jogday_iam_role_assume_policy.json
  inline_policy {
    name   = var.jogday_iam_role_log_policy_name
    policy = data.aws_iam_policy_document.log_policy_doc.json
  }
  inline_policy {
    name   = var.jogday_iam_role_sns_policy_name
    policy = data.aws_iam_policy_document.sns_policy_doc.json
  }
  inline_policy {
    name   = var.jogday_iam_role_sqs_policy_name
    policy = data.aws_iam_policy_document.sqs_policy_doc.json
  }
  inline_policy {
    name   = var.jogday_iam_role_lambda_policy_name
    policy = data.aws_iam_policy_document.lambda_policy_doc.json
  }
  inline_policy {
    name   = var.jogday_iam_role_kms_policy_name
    policy = data.aws_iam_policy_document.kms_policy_doc.json
  }
  tags = {
    Name = var.jogday_tag
  }
}

