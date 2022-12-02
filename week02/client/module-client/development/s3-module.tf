module "s3" {
	source = "../../../modules/s3"
	bucket_prefix = "soso-bucket-"
    target_bucket = "soso-bucket1"
}
