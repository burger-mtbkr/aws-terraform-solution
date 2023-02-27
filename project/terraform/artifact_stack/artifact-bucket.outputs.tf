output "artifactbucket_arn" {
  description = " Artifact bucket arn"
  value       = aws_s3_bucket.artifactbucket.arn
}