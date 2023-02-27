
# Resource to Create S3 bucket
# Examples: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "artifactbucket" {
  bucket = var.artifactbucket_name
  tags   = var.jogday_tags
}

resource "aws_s3_bucket" "storagebucket" {
  bucket = var.storagebucket_name
  tags   = var.jogday_tags
}