# DB outputs
# output "db_instance_endpoint" {
#   description = "database endpoint"
#   value       = module.db.db_instance_endpoint
# }

# output "database_port" {
#   description = "database instance port"
#   value       = module.db.db_instance_port
# }

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}