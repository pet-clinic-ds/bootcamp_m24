output "db_instance_endpoint" {
  description = "database instance  endpoint"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = module.rds.db_instance_username
  sensitive   = true
}

output "db_instance_master_user_secret_arn" {
  description = "The ARN of the master user secret (Only available when manage_master_user_password is set to true)"
  value       = module.rds.db_instance_master_user_secret_arn
}

output "db_instance_name" {
  description = "The database name"
  value       = module.rds.db_instance_name
}

