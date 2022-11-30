# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document

# module s3 access policy

data "aws_iam_policy_document" "s3_access" {
   Version = "2012-10-17"
   statement {
    effect    = "Allow"
    actions   = ["s3:*"
    
    ]
    resources = ["arn:aws:s3:::awsexamplebucket1",
                 "arn:aws:s3:::awsexamplebucket2",
                 "arn:aws:s3:::${var.tenant}-${var.module}-${var.environment}-soso-ss"
                ]
  }
}

# module s3 access policy
module "oracle_rds_S3_accesst" {
  source            = "../../modules/iam/policy"
  policy_name       = "${var.tenant}-${var.module}-${var.environment}-interact-cms-multiple-s3"
  policy_desc       = var.base_tags
  policy            = module.DX_multiple_S3_role_policys.policy_arn
  base_tags         = {
    "Name"        = "SSA-RDS-S3-Access-${var.tenant}-core-${var.environment}",
    "Environment" = var.environment,
    "POCEmail"    = "cre@sosotechnologies.com",
    "org"         = var.tenant,
    "App"         = "macaz"
  }
}

# module Iam Role
module "iam_rolet" {
  source              = "../../../../../modules/iam/role"
  enable_attachment   = true
  iam_role_name       = "rds-s3-integration-role-${var.environment}"
  iam_role_base_tags  = var.base_tags
  iam_role_policy     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "condition": {
        "StringEquals": {
          "aws:SourceArn": = "arn:aws:rde:${region}:data.aws_caller_identity.current.account_id}:db:$module.macaz-rds.rds_instance_id"
          }
        },
       
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF


resource "aws_iam_role_policy_attachment" "test-attach" {
  iam_role_base_tags = {
    "Name"        = "rds-S3-integration-role-${var.environment}",
    "Environment" = var.environment,
    "POCEmail"    = "cre@sosotechnologies.com",
    "org"         = var.tenant,
    "App"         = "macaz"
  }
 }
