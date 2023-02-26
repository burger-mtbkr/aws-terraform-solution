
# SNS topic

resource "aws_sns_topic" "jogday_sns_email_topic" {
  name = var.jogday_sns_email_topic_name
  tags = {
    Name = var.jogday_tag
  }
}

# SNS subscription to above topic
resource "aws_sns_topic_subscription" "jogday_sns_email_topic_subscription" {
  topic_arn = aws_sns_topic.jogday_sns_email_topic.arn
  protocol  = "email"
  endpoint  = "loan.burger@gmail.com"
}