
# This will create an options group
resource "aws_db_option_group" "oracle_sosotech" {
  name                     = "oracle-ee-cdb-19-s3-environment-4"
  option_group_description = "Oracle 19 S3 Option Group"
  engine_name              = "oracle-ee-cdb"
  major_engine_version     = "19"

  option {
    db_security_group_memberships  = []
    option_name                    = "S3_INTEGRATION"
    port                           = 0
    version                        = "1.0"
    vpc_security_group_memberships = []
  }
  option {
    db_security_group_memberships  = []
    option_name                    = "TDE"
    port                           = 0
    vpc_security_group_memberships = []
  }
  option {
    db_security_group_memberships  = []
    option_name                    = "JVM"
    port                           = 0
    vpc_security_group_memberships = []
  }
  option {
    db_security_group_memberships  = []
    option_name                    = "NATIVE_NETWORK_ENCRYPTION"
    port                           = 0
    vpc_security_group_memberships = []
    option_settings {
      name  = "SQLNET.ENCRYPTION_SERVER"
      value = "REQUIRED"
    }
    option_settings {
      name  = "SQLNET.ENCRYPTION_TYPES_SERVER"
      value = "AES256"
    }
    option_settings {
      name  = "SQLNET.ENCRYPTION_CLIENT"
      value = "REQUIRED"
    }
    option_settings {
      name  = "SQLNET.ENCRYPTION_TYPES_CLIENT"
      value = "AES256"
    }
  }
  option {
    db_security_group_memberships  = []
    option_name                    = "Timezone"
    port                           = 0
    vpc_security_group_memberships = []
    option_settings {
      name  = "TIME_ZONE"
      value = "US/Eastern"
    }
  }
}

locals {
  oracle_db_parameters = [
    {
      name         = "audit_trail",
      value        = "DB,EXTENDED"
      apply_method = "pending-reboot"
    },
    {
      name         = "dbfips_140",
      value        = "TRUE"
      apply_method = "pending-reboot"
    },
    {
      name  = "db_32k_cache_size"
      value = "67108864"
    },
    {
      name  = "db_cache_size"
      value = "1073741824"
    },
    {
      name         = "db_files"
      value        = "1500"
      apply_method = "pending-reboot"
    },
    {
      name  = "db_flashback_retention_target"
      value = "2880"
    },
    {
      name  = "db_recovery_file_dest_size"
      value = "107374182400"
    },
    {
      name         = "distributed_lock_timeout"
      value        = "300"
      apply_method = "pending-reboot"
    },
    {
      name  = "java_pool_size"
      value = "100663296"
    },
    {
      name  = "job_queue_processes"
      value = "1000"
    },
    {
      name  = "large_pool_size"
      value = "234881024"
    },
    {
      name  = "open_cursors"
      value = "2000"
    },
    {
      name         = "open_links"
      value        = "55"
      apply_method = "pending-reboot"
    },
    {
      name         = "recyclebin"
      value        = "ON"
      apply_method = "pending-reboot"
    },
    {
      name  = "sec_protocol_error_further_action"
      value = "(DELAY,3)"
    },
    {
      name         = "session_cached_cursors"
      value        = "100"
      apply_method = "pending-reboot"
    },
    {
      name  = "shared_pool_size"
      value = "1073741824"
    },
    {
      name         = "sql92_security"
      value        = "FALSE"
      apply_method = "pending-reboot"
    },
    {
      name  = "sqlnetora.sqlnet.allowed_logon_version_server"
      value = "8"
    },
    {
      name  = "sqlnetora.sqlnet.allowed_logon_version_client"
      value = "8"
    },
    {
      name  = "undo_retention"
      value = "10800"
    }
  ]
}

# will create a parameter group
resource "aws_db_parameter_group" "oracle_ee_soso" {
  name   = "oracle-ee-cdb-19-environment4"
  family = "oracle-ee-cdb-19"

  dynamic "parameter" {
    for_each = local.oracle_db_parameters
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier = "soso-db"
  db_name = "sosoDB"
  #   instance_class             = var.oracle_instance_type
  instance_class             = "db.r5b.large"
  engine                     = "oracle-ee-cdb"
  username = local.db_creds.username
  password = local.db_creds.password
  engine_version             = "19"
  license_model              = "bring-your-own-license"
  character_set_name         = "WE8MSWIN1252"
  option_group_name          = aws_db_option_group.oracle_sosotech.name
  parameter_group_name       = aws_db_parameter_group.oracle_ee_soso.name
  multi_az                   = false
  allocated_storage          = var.oracle_allocated_storage
  max_allocated_storage      = var.oracle_max_allocated_storage
  backup_window              = "23:00-00:00"
  auto_minor_version_upgrade = true
  apply_immediately          = true
  maintenance_window         = "Wed:01:00-Wed:02:00"
  final_snapshot_identifier           = "${var.tenant}-${var.module}-oracle-serverless-snapshot"
  enabled_cloudwatch_logs_exports     = ["alert", "audit", "listener", "trace"]
 }
