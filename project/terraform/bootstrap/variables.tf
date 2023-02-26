variable "region" {
  type        = string
  description = "Jogday region"
  default     = "ap-southeast-2"
}

variable "jogday_tag" {
  type        = string
  description = "Jogday Tag"
  default     = "jogday"
}


# Bucket vars

variable "artifactbucket_name" {
  type        = string
  description = "Jogday artifact bucket name"
  default     = "lpb-artifactbucket"
}

variable "storagebucket_name" {
  type        = string
  description = "Jogday storage bucket name"
  default     = "lpb-storagebucket"
}

variable "jogday_s3_policy_name" {
  type        = string
  description = "S3Policy policy name"
  default     = "bucket_policy"
}

# IAM Vars

variable "jogday_iam_user_name" {
  type        = string
  description = "Jogday iam user name"
  default     = "jogday_iam_user"
}



variable "jogday_lambda_policy_name" {
  type        = string
  description = "LambdaPolicy policy name"
  default     = "lambda_policy"
}


variable "jogday_sns_policy_name" {
  type        = string
  description = "SNSPolicy policy name"
  default     = "sns_policy"
}

variable "jogday_iam_role_name" {
  type        = string
  description = "Jogday iam role name"
  default     = "jogday_iam_role"
}

variable "jogday_iam_role_log_policy_name" {
  type        = string
  description = "Jogday iam role log_policy name"
  default     = "log_policy"
}

variable "jogday_iam_role_sns_policy_name" {
  type        = string
  description = "Jogday iam role sns_policy name"
  default     = "sns_policy"
}

variable "jogday_iam_role_sqs_policy_name" {
  type        = string
  description = "Jogday IAM role sqs_policy name"
  default     = "sqs_policy"
}

variable "jogday_iam_role_lambda_policy_name" {
  type        = string
  description = "Jogday IAM role lambda_policy name"
  default     = "lambda_policy"
}

variable "jogday_iam_role_kms_policy_name" {
  type        = string
  description = "Jogday IAM role kms_policy name"
  default     = "kms_policy"
}

variable "jogday_kms_policy_name" {
  type        = string
  description = "Jogday IAM kms_policy name"
  default     = "kms_policy"
}

# SQS

variable "jogday_sqs_policy_name" {
  type        = string
  description = "SQSPolicy policy name"
  default     = "sqs_policy"
}

variable "retention_period" {
  description = "Time (in seconds) that messages will remain in queue before being purged"
  type        = number
  default     = 86400
}

variable "jogday_queue_name" {
  type        = string
  description = "Jogday Main Queue name"
  default     = "JogDayQueue"
}

variable "jogday_dlq_queue_name" {
  type        = string
  description = "Jogday Dead Letter Queue name"
  default     = "DLQ"
}

variable "visibility_timeout" {
  description = "Time (in seconds) that consumers have to process a message before it becomes available again"
  type        = number
  default     = 60
}

variable "receive_count" {
  description = "The number of times that a message can be retrieved before being moved to the dead-letter queue"
  type        = number
  default     = 3
}

variable "receive_wait_time_seconds" {
  type        = number
  default     = 20
  description = "Time (in seconds) that messages will be received"
}
