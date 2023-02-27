output "aws_iam_user_arn" {
  description = "Jogday iam user arn"
  value       = aws_iam_user.jogday_iam_user.arn
}