# SQS

resource "aws_sqs_queue" "jogday_integration_queue" {
  name                       = var.jogday_integration_queue_name
  message_retention_seconds  = var.retention_period
  visibility_timeout_seconds = var.visibility_timeout
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  redrive_policy = jsonencode({
    "maxReceiveCount"     = var.receive_count
  })
  tags = var.jogday_tags
}


##
## the policy statements are defined as locals so that they can be
## used by the consuming module to build a larger policy
##

locals {
  consumer_policy_statement = {
    "Sid"    = "c${sha1(aws_sqs_queue.jogday_integration_queue.arn)}"
    "Effect" = "Allow",
    "Action" = [
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage"
    ],
    "Resource" = [
      aws_sqs_queue.jogday_integration_queue.arn
    ]
  }

  producer_policy_statement = {
    "Sid"    = "p${sha1(aws_sqs_queue.jogday_integration_queue.arn)}"
    "Effect" = "Allow",
    "Action" = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:SendMessage",
      "sqs:SendMessageBatch"
    ],
    "Resource" = [
      aws_sqs_queue.jogday_integration_queue.arn
    ]
  }
}

##
## managed policies are created for convenience when there's
## just a few queues that an application might use
##

resource "aws_iam_policy" "consumer_policy" {
  name        = "SQS-${var.jogday_integration_queue_name}-${var.region}-consumer"
  description = "Attach this policy to consumers of the ${var.jogday_integration_queue_name} queue"
  policy = jsonencode({
    "Version"   = "2012-10-17",
    "Statement" = [local.consumer_policy_statement]
  })
  tags = var.jogday_tags
}


resource "aws_iam_policy" "producer_policy" {
  name        = "SQS-${var.jogday_integration_queue_name}-${var.region}-producer"
  description = "Attach this policy to producers for the ${var.jogday_integration_queue_name} queue"
  policy = jsonencode({
    "Version"   = "2012-10-17",
    "Statement" = [local.producer_policy_statement]
  })
  tags = var.jogday_tags
}