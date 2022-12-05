provider "aws" {
  region  = "us-west-2"
}

resource "aws_s3_bucket" "soso-bucket" {
  bucket = "my-bucket-name"
}

resource "aws_s3_bucket" "soso_bucket" {
  bucket = "my-bucket-name"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "soso_bucket_access" {
  bucket = aws_s3_bucket.soso_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

resource "aws_iam_policy" "bucket_policy" {
  name        = "soso-bucket-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*",
          "arn:aws:s3:::my-bucket-name"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "soso_role" {
  name = "my_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "soso_bucket_policy" {
  role       = aws_iam_role.soso_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloud_watch_policy" {
  role       = aws_iam_role.soso_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# resource "aws_iam_instance_profile" "some_profile" {
#   name = "some-profile"
#   role = aws_iam_role.some_role.name
# }

# resource "aws_instance" "web_instances" {
#   ami           = "ami-03ab7423a204da002"
#   instance_type = "t2.micro"

#   iam_instance_profile = aws_iam_instance_profile.some_profile.id
# }
