module "eks" {

  source                         = "terraform-aws-modules/eks/aws"
  version                        = "20.11.1"
  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  create_cloudwatch_log_group              = var.create_cloudwatch_log_group
  cluster_enabled_log_types                = null


  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  eks_managed_node_group_defaults = {
    ami_type       = var.ami_type
    instance_types = var.instance_types
  }

  eks_managed_node_groups = {
    default_node_group = {
      name         = "petclinic-node-group"
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size
      description  = "EKS managed node group for petclinic"
    }
  }
}

#Creates an IAM role which can be assumed by AWS EKS ServiceAccount
module "iam_role_service_accounts" {
  source                                 = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                                = "5.39.1"
  role_name                              = var.role_name
  attach_load_balancer_controller_policy = var.attach_load_balancer_controller_policy

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:${var.serviceAccount_name}"]
    }
  }
}

resource "kubernetes_service_account" "service-account" {
  metadata {
    name      = var.serviceAccount_name
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name"      = var.serviceAccount_name
      "app.kubernetes.io/component" = "controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn"               = module.iam_role_service_accounts.iam_role_arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}
resource "helm_release" "alb-controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "region"
    value = var.region_name
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "serviceAccount.create"
    value = var.serviceAccount_create
  }

  set {
    name  = "serviceAccount.name"
    value = var.serviceAccount_name
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  depends_on = [
    kubernetes_service_account.service-account
  ]
}