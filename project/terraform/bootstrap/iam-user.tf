
# IAM User Creation with Policies
# Examples: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user

resource "aws_iam_user" "jogday_iam_user" {
  name = var.jogday_iam_user_name
  tags = var.jogday_tags
}

#############################################################################

# S3 bucket policy document
data "aws_iam_policy_document" "s3_bucket_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      "*"
    ]
  }
}

# S3 bucket policy
resource "aws_iam_policy" "bucket_policy" {
  name        = var.jogday_s3_policy_name
  description = "S3 policy"
  policy      = data.aws_iam_policy_document.s3_bucket_policy_doc.json
  tags        = var.jogday_tags
}

# Attaching "bucket_policy" policy to the user
resource "aws_iam_user_policy_attachment" "user-s3-policy-relationship" {
  depends_on = [aws_iam_user.jogday_iam_user, aws_iam_policy.bucket_policy]
  user       = aws_iam_user.jogday_iam_user.id
  policy_arn = aws_iam_policy.bucket_policy.arn
}

#############################################################################

# Lambda policy document
data "aws_iam_policy_document" "lambda_bucket_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "lambda:*",
    ]
    resources = [
      "*"
    ]
  }
}

# Lambda policy
resource "aws_iam_policy" "lambda_policy" {
  name        = var.jogday_lambda_policy_name
  description = "Lambda policy"
  policy      = data.aws_iam_policy_document.lambda_bucket_policy_doc.json
  tags        = var.jogday_tags
}

# Attaching "lambda_policy" policy to the user
resource "aws_iam_user_policy_attachment" "user-lambda-policy-relationship" {
  depends_on = [aws_iam_user.jogday_iam_user, aws_iam_policy.lambda_policy]
  user       = aws_iam_user.jogday_iam_user.id
  policy_arn = aws_iam_policy.lambda_policy.arn
}

#############################################################################

# SQS policy document
data "aws_iam_policy_document" "sqs_bucket_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:*",
    ]
    resources = [
      "*"
    ]
  }
}

# SQS policy
resource "aws_iam_policy" "sqs_policy" {
  name        = var.jogday_sqs_policy_name
  description = "SQS policy"
  policy      = data.aws_iam_policy_document.sqs_bucket_policy_doc.json
  tags        = var.jogday_tags
}

# Attaching "sqs_policy" policy to the user
resource "aws_iam_user_policy_attachment" "user-sqs-policy-relationship" {
  depends_on = [aws_iam_user.jogday_iam_user, aws_iam_policy.sqs_policy]
  user       = aws_iam_user.jogday_iam_user.id
  policy_arn = aws_iam_policy.sqs_policy.arn
}

#############################################################################

# SNS policy document
data "aws_iam_policy_document" "sns_bucket_policy_doc" {
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

# SNS policy
resource "aws_iam_policy" "sns_policy" {
  name        = var.jogday_sns_policy_name
  description = "SNS policy"
  policy      = data.aws_iam_policy_document.sns_bucket_policy_doc.json
  tags        = var.jogday_tags
}

# Attaching "sns_policy" policy to the user
resource "aws_iam_user_policy_attachment" "user-sns-policy-relationship" {
  depends_on = [aws_iam_user.jogday_iam_user, aws_iam_policy.sns_policy]
  user       = aws_iam_user.jogday_iam_user.id
  policy_arn = aws_iam_policy.sns_policy.arn
}