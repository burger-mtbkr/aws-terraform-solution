# Resource for KMS Key Creation
# Example: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
# Principals info : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document

data "aws_iam_policy_document" "aws_kms_iam_policy_doc" {
  statement {
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::313687599080:root", aws_iam_role.jogday_iam_role.arn, aws_iam_user.jogday_iam_user.arn]
    }
  }
}


resource "aws_kms_key" "jogday_kms_key" {
  description             = "JogDay KMS Key"
  depends_on              = [aws_iam_user.jogday_iam_user, aws_iam_role.jogday_iam_role]
  deletion_window_in_days = 10
  is_enabled              = true
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.aws_kms_iam_policy_doc.json
  tags = {
    Name = var.jogday_tag
  }
}