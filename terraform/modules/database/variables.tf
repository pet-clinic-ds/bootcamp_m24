variable "engine_name" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "major_engine_version" {
  description = "	Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "8.0"
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "mysql8.0"
}

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
  default     = "petclinic-rds-instance"
}
variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "petclinicdb"
}
variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.small"
}
variable "manage_master_user_password" {
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager"
  type        = bool
  default     = false
}
variable "password" {
  description = "	Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file.The password provided will not be used if manage_master_user_password is set to true."
  type        = string
  sensitive   = true
}


variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = true

}
variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}


variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}


variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 5
}

variable "port" {
  description = "	The port on which the DB accepts connections"
  type        = number
  default     = 3306
}
variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "03:00-06:00"

}
variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}
variable "protocol" {
  description = "protocol"
  type        = string
  default     = "tcp"

}
variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
  default     = "adm"
}

variable "sg_name" {
  type    = string
  default = "petclinic-sg"
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}
variable "database_subnet_group" {
  description = "ID of database subnet group"
}