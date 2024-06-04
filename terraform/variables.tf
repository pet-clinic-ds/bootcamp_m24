variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
variable "gitlab_access_token" {
  type      = string
  sensitive = true
}
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
variable "project_id" {
  description = "Id of the gitlab project"
  type        = string
}

