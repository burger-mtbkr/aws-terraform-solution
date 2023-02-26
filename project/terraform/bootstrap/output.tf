output "artifactbucket_arn" {
  description = " Artifact bucket arn"
  value       = aws_s3_bucket.artifactbucket.arn
}

output "storagebucket_arn" {
  description = " Storage bucket arn"
  value       = aws_s3_bucket.storagebucket.arn
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


# SQS

output "jogday_queue" {
  value = aws_sqs_queue.jogday_queue.id
}


output "deadletter_queue_url" {
  value = aws_sqs_queue.deadletter_queue.id
}


output "consumer_policy_statement" {
  value = local.consumer_policy_statement
}


output "producer_policy_statement" {
  value = local.producer_policy_statement
}


output "consumer_policy_arn" {
  value = aws_iam_policy.consumer_policy.arn
}


output "producer_policy_arn" {
  value = aws_iam_policy.producer_policy.arn
}

