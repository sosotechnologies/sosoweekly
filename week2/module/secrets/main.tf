# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret


resource "aws_secretsmanager_secret" "sosotech_secret" {
  name = var.secret_name
  description = var.secret_desc
  kms_key_id = var.kms_key_id
}

resource "aws_secretsmanager_secret_version" "sosotech_secret_version" {
  count         = var.manual_input ? 0 : 1
  secret_id     = aws_secretsmanager_secret.sosotech_secret.id      #referenced from the above line 18S
  secret_string = var.secret_string
}
