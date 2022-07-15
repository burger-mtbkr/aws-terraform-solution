output "artifactbucket_arn" {
  description = " Artifact bucket arn"
  value       = aws_s3_bucket.artifactbucket.arn
}

output "jogday_iam_user_arn" {
  description = "Jogday iam user arn"
  value       = aws_iam_user.jogday_iam_user.arn
}

output "aws_iam_role_arn" {
  description = "Jogday iam role arn"
  value       = aws_iam_role.jogday_iam_role.arn
}

output "jogday_kms_key_arn" {
  value       = aws_kms_key.jogday_kms_key.arn
  description = "Jogday kms key arn"
}
