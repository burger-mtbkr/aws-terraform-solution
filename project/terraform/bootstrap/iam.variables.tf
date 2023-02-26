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