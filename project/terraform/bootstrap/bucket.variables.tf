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