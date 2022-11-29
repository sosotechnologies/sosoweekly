output "user_name" {
  description = "IAM user name"
  value       = join("", aws_iam_user.default.*.name)
}

output "user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = join("", aws_iam_user.default.*.arn)
}

output "user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = join("", aws_iam_user.default.*.unique_id)
}

