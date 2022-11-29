# resource "aws_db_option_group" "oracle_ee_cdb_4" {
#   name                     = "oracle-ee-cdb-19-s3-${var.environment}-4"
#   option_group_description = "Oracle 19 S3 Option Group"
#   engine_name              = "oracle-ee-cdb"
#   major_engine_version     = "19"

#   option {
#     db_security_group_memberships  = []
#     option_name                    = "S3_INTEGRATION"
#     port                           = 0
#     version                        = "1.0"
#     vpc_security_group_memberships = []
#   }
#   option {
#     db_security_group_memberships  = []
#     option_name                    = "TDE"
#     port                           = 0
#     vpc_security_group_memberships = []
#   }
#   option {
#     db_security_group_memberships  = []
#     option_name                    = "JVM"
#     port                           = 0
#     vpc_security_group_memberships = []
#   }
#   option {
#     db_security_group_memberships  = []
#     option_name                    = "NATIVE_NETWORK_ENCRYPTION"
#     port                           = 0
#     vpc_security_group_memberships = []
#     option_settings {
#       name  = "SQLNET.ENCRYPTION_SERVER"
#       value = "REQUIRED"
#     }
#     option_settings {
#       name  = "SQLNET.ENCRYPTION_TYPES_SERVER"
#       value = "AES256"
#     }
#     option_settings {
#       name  = "SQLNET.ENCRYPTION_CLIENT"
#       value = "REQUIRED"
#     }
#     option_settings {
#       name  = "SQLNET.ENCRYPTION_TYPES_CLIENT"
#       value = "AES256"
#     }
#   }
#   option {
#     db_security_group_memberships  = []
#     option_name                    = "Timezone"
#     port                           = 0
#     vpc_security_group_memberships = []
#     option_settings {
#       name  = "TIME_ZONE"
#       value = "US/Eastern"
#     }
#   }
# }

# locals {
#   oracle_db_parameters_4 = [
#     {
#       name         = "audit_trail",
#       value        = "DB,EXTENDED"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "dbfips_140",
#       value        = "TRUE"
#       apply_method = "pending-reboot"
#     },
#     {
#       name  = "db_32k_cache_size"
#       value = "67108864"
#     },
#     {
#       name  = "db_cache_size"
#       value = "1073741824"
#     },
#     {
#       name         = "db_files"
#       value        = "1500"
#       apply_method = "pending-reboot"
#     },
#     {
#       name  = "db_flashback_retention_target"
#       value = "2880"
#     },
#     {
#       name  = "db_recovery_file_dest_size"
#       value = "107374182400"
#     },
#     {
#       name         = "distributed_lock_timeout"
#       value        = "300"
#       apply_method = "pending-reboot"
#     },
#     {
#       name  = "java_pool_size"
#       value = "100663296"
#     },
#     {
#       name  = "job_queue_processes"
#       value = "1000"
#     },
#     {
#       name  = "large_pool_size"
#       value = "234881024"
#     },
#     {
#       name  = "open_cursors"
#       value = "2000"
#     },
#     {
#       name         = "open_links"
#       value        = "55"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "recyclebin"
#       value        = "ON"
#       apply_method = "pending-reboot"
#     },
#     {
#       name  = "sec_protocol_error_further_action"
#       value = "(DELAY,3)"
#     },
#     {
#       name         = "session_cached_cursors"
#       value        = "100"
#       apply_method = "pending-reboot"
#     },
#     {
#       name  = "shared_pool_size"
#       value = "1073741824"
#     },
#     {
#       name         = "sql92_security"
#       value        = "FALSE"
#       apply_method = "pending-reboot"
#     },
#     {
#       name  = "sqlnetora.sqlnet.allowed_logon_version_server"
#       value = "8"
#     },
#     {
#       name  = "sqlnetora.sqlnet.allowed_logon_version_client"
#       value = "8"
#     },
#     {
#       name  = "undo_retention"
#       value = "10800"
#     }
#   ]
# }

# resource "aws_db_parameter_group" "oracle_ee_cdb_4" {
#   name   = "oracle-ee-cdb-19-${var.environment}-4"
#   family = "oracle-ee-cdb-19"

#   dynamic "parameter" {
#     for_each = local.oracle_db_parameters_4
#     content {
#       name         = parameter.value["name"]
#       value        = parameter.value["value"]
#       apply_method = lookup(parameter.value, "apply_method", "immediate")
#     }
#   }
# }

# # module "sosotech-rds-database_4" {
# #   #source = "git@github.helix.gsa.gov:sosotech/terraform-modules.git//rds-oracle"

# #   identifier = "${var.tenant}-${var.module}-${var.environment}-db-4"
# #   name       = var.oracle_db_name
# #   #   instance_class             = var.oracle_instance_type
# #   instance_class             = "db.r5b.large"
# #   engine                     = "oracle-ee-cdb"
# #   engine_version             = "19"
# #   license_model              = "bring-your-own-license"
# #   character_set_name         = "WE8MSWIN1252"
# #   option_group_name          = aws_db_option_group.oracle_ee_cdb_4.name
# #   parameter_group_name       = aws_db_parameter_group.oracle_ee_cdb_4.name
# #   multi_az                   = false
# #   allocated_storage          = var.oracle_allocated_storage
# #   max_allocated_storage      = var.oracle_max_allocated_storage
# #   backup_window              = "23:00-00:00"
# #   auto_minor_version_upgrade = true
# #   maintenance_window         = "Wed:01:00-Wed:02:00"

# #   subnet_grp_name        = "${var.tenant}-${var.module}-${var.environment}-4-oracle-subnetgroup"
# #   create_subnet_group    = true
# #   vpc_security_group_ids = [var.oracle_rds_vpc_security_group, module.data_access_sg.sosotech_security_group_id]
# #   subnet_ids             = var.oracle_db_subnets
# #   subnet_grp_description = "${var.tenant}-${var.module}-${var.environment}-4 RDS Oracle Database Subnet group"

# #   environment                         = var.environment_short_code
# #   kms_key_id                          = module.sosotech_kms_key.key_arn
# #   deletion_protection                 = true
# #   final_snapshot_identifier           = "${var.tenant}-${var.module}-oracle-serverless-snapshot"
# #   username                            = "${var.tenant}${var.environment}dbadmin"
# #   iam_database_authentication_enabled = false
# #   storage_encrypted                   = true
# #   enabled_cloudwatch_logs_exports     = ["alert", "audit", "listener", "trace"]
# #   apply_immediately                   = true

# #   #restore_to_point_in_time = {
# #     #restore_time = "2022-11-03T13:01:59Z" # set to whatever datetime is desired, so long as it is within the backup restore period (can see from AWS RDS automated backups console)
# #     # use_latest_restorable_time

# #    # source_db_instance_identifier = "${var.tenant}-${var.module}-${var.environment}-db"
# #   #}
# # }

# resource "aws_db_instance_role_association" "s3_dump_4" {
#   db_instance_identifier = module.sosotech-rds-database_4.rds_instance_id
#   feature_name           = "S3_INTEGRATION"
#   role_arn               = module.iam_role_4.iam_role_arn
# }

# locals {
#   connectiondetails_4 = {
#     address  = module.sosotech-rds-database_4.rds_endpoint
#     port     = module.sosotech-rds-database_4.rds_port
#     username = module.sosotech-rds-database_4.rds_username
#     password = module.sosotech-rds-database_4.rds_password
#     dbname   = module.sosotech-rds-database_4.rds_instance_name
#   }
# }

# module "rds-oracle-secret_4" {
#   source        = "./modules/secrets"
#   secret_name   = "${var.tenant}-${var.module}-${var.environment}-4-rds-oracle-creds"
#   secret_desc   = "${var.tenant} ${var.module} ${var.environment}-4 rds oracle connection creds"
#   kms_key_id    = var.secrets_manager_key_alias_arn
#   secret_string = jsonencode(local.connectiondetails_4)
# }

# module "oracle-rds-secret-connection-string_4" {

#   source        = "./modules/secrets"
#   secret_name   = "${var.tenant}-${var.module}-${var.environment}-4-sosotech-oracledb-connectionstring-0001"
#   secret_desc   = "${var.tenant} ${var.module} ${var.environment}-4 oracle rds connection string"
#   kms_key_id    = var.secrets_manager_key_alias_arn
#   secret_string = module.sosotech-rds-database_4.rds_endpoint
# }

# module "oracle-rds-secret-username_4" {

#   source        = "./modules/secrets"
#   secret_name   = "${var.tenant}-${var.module}-${var.environment}-4-sosotech-oracledb-username-0001"
#   secret_desc   = "${var.tenant} ${var.module} ${var.environment}-4 oracle rds username"
#   kms_key_id    = var.secrets_manager_key_alias_arn
#   secret_string = module.sosotech-rds-database_4.rds_username
# }

# module "oracle-rds-secret-password_4" {

#   source        = "./modules/secrets"
#   secret_name   = "${var.tenant}-${var.module}-${var.environment}-4-sosotech-oracledb-password-0001"
#   secret_desc   = "${var.tenant} ${var.module} ${var.environment}-4 oracle rds password"
#   kms_key_id    = var.secrets_manager_key_alias_arn
#   secret_string = module.sosotech-rds-database_4.rds_password
# }

# module "oracle-rds-secret-dbname_4" {

#   source        = "./modules/secrets"
#   secret_name   = "${var.tenant}-${var.module}-${var.environment}-4-sosotech-oracledb-dbname-0001"
#   secret_desc   = "${var.tenant} ${var.module} ${var.environment}-4 oracle rds dbname"
#   kms_key_id    = var.secrets_manager_key_alias_arn
#   secret_string = module.sosotech-rds-database_4.rds_instance_name
# }