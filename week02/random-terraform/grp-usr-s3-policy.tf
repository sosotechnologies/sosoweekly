terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# user in SosoTechAdmin group 
resource "aws_iam_user" "soso_user" {
  name = "soso_user_1"
}

# user access Key
resource "aws_iam_access_key" "my_access_key" {
  user = aws_iam_user.soso_user.name
  pgp_key = var.pgp_key
}

resource "random_pet" "pet_name" {
  length    = 3
  separator = "-"
}

# create S3 bucket
resource "aws_s3_bucket" "soso_bucket" {
  bucket = "${random_pet.pet_name.id}-bucket"
  acl    = "private"

  tags = {
    Name        = "sosotech bucket"
    Environment = "Dev"
  }
}

# s3 IAM bucket policy
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["arn:aws:s3:::*"]
    effect = "Allow"
  }
  statement {
    actions   = ["s3:*"]
    resources = [aws_s3_bucket.soso_bucket.arn]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "soso_policy" {
  name        = "${random_pet.pet_name.id}-policy"
  description = "My test policy"
  policy = data.aws_iam_policy_document.s3_policy.json
}

# User Groups 
resource "aws_iam_group" "soso_admin_group" {
  name = "SosoTechAdmin"
}

resource "aws_iam_group_policy_attachment" "custom_policy" {
  group      = aws_iam_group.soso_admin_group.name
  policy_arn = aws_iam_policy.soso_policy.arn
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.soso_user.name,
  ]

  group = aws_iam_group.soso_admin_group.name
}

# output.tf
output "rendered_policy" {
  value = data.aws_iam_policy_document.s3_policy.json
}

output "secret" {
  value = aws_iam_access_key.my_access_key.encrypted_secret
  sensitive = true
}

# variable.tf
variable "region" {
  default = "us-east-1"
}

variable "pgp_key" {
 description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt the password and the access key on output to the console."
 default     = ""
}
