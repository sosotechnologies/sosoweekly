module "rds_oracle_S3" {
  source                = "../../modules/s3"
  soso_bucket_name      = "${var.tenant}-${var.module}-${var.environment}-s3"
  soso_bucket_env       = var.environment
  access_log_s3_name    = "macaz-s3-server-logs"
  }

module "rds_oracle_S3_attachment" {
  source                = "../../modules/s3"
  soso_bucket_name      = "${var.tenant}-${var.module}-${var.environment}-s3"
  soso_bucket_env       = var.environment
  access_log_s3_name    = "macaz-s3-server-logs"
  }

