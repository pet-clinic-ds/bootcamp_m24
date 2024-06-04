variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of IDs of private subnets"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The Kubernetes version for the cluster"
  type        = string
  default     = "1.30"
}
variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}
variable "enable_cluster_creator_admin_permissions" {
  description = "Indicates whether or not to add the cluster creator (the identity used by Terraform) as an administrator via access entry"
  type        = bool
  default     = true
}
variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = false
}
variable "ami_type" {
  description = "Amazon Machine Image (AMI) type"
  type        = string
  default     = "AL2_x86_64"
}
variable "instance_types" {
  description = "Amazon Machine Image (AMI) instance type "
  type        = list(string)
  default     = ["t2.medium"]
}
variable "region_name" {
  type    = string
  default = "eu-west-3"
}
variable "serviceAccount_create" {
  type    = bool
  default = false
}
variable "serviceAccount_name" {
  type    = string
  default = "petclinic-service-account"
}
variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum node group size"
}
variable "max_size" {
  type        = number
  default     = 1
  description = "Maximum  node group size"
}
variable "desired_size" {
  type        = number
  default     = 1
  description = "Desired  node group size"
}
variable "role_name" {
  type        = string
  default     = "petclinic_eks_role"
  description = "role name"
}

variable "attach_load_balancer_controller_policy" {
  type        = bool
  default     = true
  description = "Determines whether to attach the Load Balancer Controller policy to the role"
}



