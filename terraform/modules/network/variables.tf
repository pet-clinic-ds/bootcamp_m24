
variable "vpc_name" {
  type    = string
  default = "petclinic-vpc"
}

variable "region_name" {
  type    = string
  default = "eu-west-3"
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created (n.b. database_subnets must also be set)"
  type        = bool
  default     = true
}

variable "create_database_subnet_route_table" {
  description = "	Controls if separate route table for database should be created"
  type        = bool
  default     = false
}

variable "create_database_internet_gateway_route" {
  description = "Controls if an internet gateway route for public database access should be created"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "	Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "	Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}