# resource "aws_s3_bucket" "dedon_bucket" {
#   bucket = var.dedon_bucket_name
#   acl    = "private"

#   versioning  {
#     enabled = true
#   }
  
#   logging  {
#     target_bucket = var.access_log_s3_name
#     target_prefix = "${var.dedon_bucket_name}/"
#   }
  
#   server_side_encryption_configuration {
#     rule {
#      apply_server_side_encryption_by_default {
#        sse_algorithm     = "AES256"
#      }
#     }
#   }

#   tags = {
#     Name          =  var.dedon_bucket_name
#     Environmenr   =  var.dedon_bucket_env
#     App           =  "dedon"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "dedon_bucket_access"{
#   bucket                  = var.dedon_bucket_name
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_policy" "bucket_policy" {
#   count  = var.decon_bucker_policy == null ? 0 : 1
#   bucket = aws_s3_bucket.dedon_bucket.id
#   policy = var.dedon_bucket_policy
# }

resource "aws_s3_bucket" "b" {
  bucket_prefix = var.bucket_prefix
  acl    = var.acl

    versioning {
        enabled = var.versioning
    }

    logging {
        target_bucket = var.target_bucket
        target_prefix = var.target_prefix
    }

    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_master_key_id
        sse_algorithm     = var.sse_algorithm
      }
    }
  }

    tags = var.tags
}
