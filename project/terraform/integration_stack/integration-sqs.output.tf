output "jogday_integration_queue" {
  value = aws_sqs_queue.jogday_integration_queue.id
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