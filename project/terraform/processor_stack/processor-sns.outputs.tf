output "jogday_sns_email_topic_arn" {
  value = aws_sns_topic.jogday_sns_email_topic.arn
}

output "jogday_sns_email_topic_subscription_arn" {
  value = aws_sns_topic_subscription.jogday_sns_email_topic_subscription.arn
}