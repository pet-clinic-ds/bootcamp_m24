module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.6.0"

  identifier           = var.identifier
  engine               = var.engine_name
  major_engine_version = var.major_engine_version
  family               = var.family
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage

  db_name                     = var.db_name
  username                    = var.db_username
  manage_master_user_password = var.manage_master_user_password
  password                    = var.password
  port                        = var.port

  multi_az               = var.multi_az
  db_subnet_group_name   = var.database_subnet_group
  vpc_security_group_ids = [module.security_group.security_group_id]

  backup_window           = var.backup_window
  backup_retention_period = var.backup_retention_period

  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = var.sg_name
  description = "Allow Mysql inbound traffic"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.port
      to_port     = var.port
      protocol    = var.protocol
      description = "MySQL access from within VPC"
      cidr_blocks = var.vpc_cidr_block
    }
  ]
}