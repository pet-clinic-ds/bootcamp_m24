provider "aws" {
  region = "eu-west-3"
}

terraform {
  backend "http" {
  }
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "17.0.0"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_access_token
}

provider "kubernetes" {
  host                   = module.web.cluster_endpoint
  cluster_ca_certificate = base64decode(module.web.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.web.cluster_endpoint
    cluster_ca_certificate = base64decode(module.web.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}


module "network" {
  source       = "./modules/network"
  cluster_name = var.cluster_name
}

module "database" {
  source                = "./modules/database"
  vpc_id                = module.network.vpc_id
  vpc_cidr_block        = module.network.vpc_cidr_block
  database_subnet_group = module.network.database_subnet_group
  password              = var.password
}

module "web" {
  source          = "./modules/web"
  vpc_cidr_block  = module.network.vpc_cidr_block
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets
  cluster_name    = var.cluster_name
}

resource "gitlab_project_variable" "db_instance_endpoint" {
  project = var.project_id
  key     = "TF_VAR_DB_INSTANCE_ENDPOINT"
  value   = module.database.db_instance_endpoint
}

resource "gitlab_project_variable" "db_instance_username" {
  project = var.project_id
  key     = "TF_VAR_DB_INSTANCE_USERNAME"
  value   = module.database.db_instance_username
}

resource "gitlab_project_variable" "db_instance_name" {
  project = var.project_id
  key     = "TF_VAR_DB_INSTANCE_NAME"
  value   = module.database.db_instance_name
}






