
#Resource to create s3 bucket
resource "aws_s3_bucket" "artifactbucket" {
  bucket = var.artifactbucket_name
  tags = {
    Name = var.jogday_tag
  }
}