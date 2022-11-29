# output
output "sosotech_secret_arn" {
  description = "The secret arn"
  value       = aws_secretsmanager_secret.sosotech_secret.arn
}

output "sosotech_secret_id" {
  description = "The secret id"
  value       = aws_secretsmanager_secret.sosotech_secrets.id
}