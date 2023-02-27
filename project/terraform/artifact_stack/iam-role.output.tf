output "aws_iam_role_arn" {
  description = "Jogday iam role arn"
  value       = aws_iam_role.jogday_iam_role.arn
}