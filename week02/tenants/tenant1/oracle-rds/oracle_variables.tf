# Oracle Variables

variable "tenant" {
  description = "The name of the tenant"
  default        = "macaz"
}

variable "module" {
  description = "The name of the module"
  default        = "core"
}

variable "environment" {
  description = "The name of the Environment"
  default        = "staging"
}


variable "refion" {
  default        = "us-east-1"
}

variable "environment_short_code" {
  description = "The name of the Environment short code"
  default        = "S"
}

variable "oracle_instance_type" {
  description = "The instance type of the RDS instance"
  default     = "db.r5b.xlarge"
}

variable "oracle_db_name" {
  default     = "STAGEDB"
}

variable "oracle_rds_vpc_security_group" {
  description = "<tenant>-<module-<env>-data-access-sg"
  default     = "sg-0bd7d3fc0841ee484"  #apply your own SG
}

variable "oracle_allocated_storage" {
  description = "The allocated storage in gigabytes"
  default     = 1000
}

variable "oracle_max_allocated_storage" {
  description = "The allocated max storage in gigabytes"
  default     = 3000
}

variable "oracle_rds_subnets" {
  description = "SN-Macaz-<tenant>-1-<env>-data-1<index>-0 subnets"
  default     = ["subnet-04c84e2efb4cbe1a7", "subnet-0d2d3c38fed0a6db5"]
}

variable "secret_manager_key_alias_arn" {
   description = "macaz index -0 subnets"
  default = "arn:awn:kms:us-east-1:888599959599:alias/macaz-code-staging-secrets-manager-key-558999999ff8888ff"
}

variable "vpc_id" {
  default = "vpc-05b6400ba7b22f7eb"
}

variable "s3_user_name_staging" {
  default = "macaz-s3-cli-service-account-staging"
}

variable "eks-oicd" {
  default = "macaz-s3-cli-service-account-staging"
  description = "oidc Id for tenants eks cluster in this env"
}

variable "eks-oicd" {
  default = "macaz-s3-cli-service-account-staging"
  description = "oidc Id for tenants eks cluster in this env"
}

variable "k8s_version" {
  default = "1.21"
}

variable "platform_mgmt_security_group_name" {
  default = "prod-eks-nodes-traffic-platform-mgmt-sg"
}

variable "ebs_kms_key_id" {
  default = "f444444848484-vjffkkff995-fjgit9ritrj"
  description = "ebs encryption key for this cluster"
}

variable "efs_name" {
  default = "sftp"
}

variable "soso_aws_code" {
  default "041-SP"
}

variable "use_snapshots" {
  default = true
}

variable "s3_cli_access_policy_name_staging" {
  default = "SSA-EKS-Cluster-S3-IAM-User-S3-Access-macaz-dedon-staging"
  description = "the policy name"
}

variable "s3_cli_access_policy_desc_staging" {
  default = "SSA-EKS-Cluster-S3-IAM-User-S3-Access-macaz-dedon-staging"
  description = "the policy description"
}

variable "s3_cli_access_policy_base_tag_staging" {
  type        = map(string)
  description = "the policy tags"
  default = {
    "Name" = "SSA-Macaz-s3_cli_access_point"
  }
}

variable "istio_lb_name" {
  default = "a22486495035648399293c"
}
