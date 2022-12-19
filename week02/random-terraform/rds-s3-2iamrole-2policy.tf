# resource "aws_s3_bucket" "collins-bucket" {
#   bucket = "my-bucket-name"
# }

# resource "aws_s3_bucket" "collins_bucket" {
#   bucket = "my-bucket-name"
#   force_destroy = true
# }

# resource "aws_s3_bucket_public_access_block" "collins_bucket_access" {
#   bucket = aws_s3_bucket.collins_bucket.id

#   block_public_acls   = true
#   block_public_policy = true
#   ignore_public_acls  = true
# }

resource "aws_iam_policy" "import_bucket_policy" {
  name        = "import-bucket-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "s3import",
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

resource "aws_iam_role" "postgres_import_role" {
  name = "import_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "rds.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "import_bucket_policy" {
  role       = aws_iam_role.postgres_import_role.name
  policy_arn = aws_iam_policy.import_bucket_policy.arn
}


resource "aws_iam_policy" "export_bucket_policy" {
  name        = "export-bucket-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "s3export",
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

resource "aws_iam_role" "postgres_export_role" {
  name = "export_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "rds.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "export_bucket_policy" {
  role       = aws_iam_role.postgres_export_role.name
  policy_arn = aws_iam_policy.export_bucket_policy.arn
}


# resource "aws_iam_role_policy_attachment" "cloud_watch_policy" {
#   role       = aws_iam_role.collins_role.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
# }

# psql --host=soso-databasee-instance-1.cvpcl54gw6xs.us-east-1.rds.amazonaws.com --port=5432 --username=soso-databasee --password
#  aws rds describe-db-engine-versions --engine aurora-postgresql
#  aws rds describe-db-clusters
