module "aurora" {
  
  for_each = toset(["blue","green"])
  
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.2.2"

  name = "${local.name_prefix}-aurora-postgres-db-${each.key}"

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts

  engine               = var.rds_engine
  engine_version       = var.rds_engine_version

  instances = {
    1 = {
      instance_class        = var.rds_instance_class
      publicly_accessible   = false
    }
  }

  storage_encrypted      = false
  create_security_group  = false
  create_random_password = false

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  database_name   = var.rds_db_name
  master_username = var.rds_db_username
  master_password = var.rds_db_password
  port            = var.rds_db_port

  vpc_id                 = module.vpc.vpc_id
  subnets                = module.vpc.database_subnets
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  preferred_maintenance_window      = "Mon:00:00-Mon:03:00"
  preferred_backup_window           = "03:00-06:00"

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = local.tags
}
