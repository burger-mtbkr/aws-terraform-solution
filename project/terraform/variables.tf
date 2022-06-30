variable "region" {
  type        = string
  description = "Jogday"
  default     = "ap-southeast-2"
}

variable "artifactbucket_name" {
  type        = string
  description = "Jogday artifact bucket name"
  default     = "lpb-artifactbucket"
}

variable "jogday_tag" {
  type        = string
  description = "Jogday Tag"
  default     = "jogday"
}

variable "jogday_iam_user_name" {
  type        = string
  description = "Jogday iam user name"
  default     = "jogday_iam_user"
}

variable "jogday_s3_policy_name" {
  type        = string
  description = "S3Policy policy name"
  default     = "bucket_policy"
}

variable "jogday_lambda_policy_name" {
  type        = string
  description = "LambdaPolicy policy name"
  default     = "lambda_policy"
}

variable "jogday_sqs_policy_name" {
  type        = string
  description = "SQSPolicy policy name"
  default     = "sqs_policy"
}

variable "jogday_sns_policy_name" {
  type        = string
  description = "SNSPolicy policy name"
  default     = "sns_policy"
}
