module "networking" {
  source       = "./networking"
  vpc_cidr     = var.vpc_cidr
  environment  = var.environment
  cluster_name = var.cluster_name
}

module "iam" {
  source            = "./iam"
  environment       = var.environment
  cluster_name      = var.cluster_name
  oidc_provider_url = module.eks.oidc_provider_url
  oidc_provider_arn = module.eks.oidc_provider_arn
}

module "ecr" {
  source          = "./ecr"
  environment     = var.environment
  repository_name = var.repository_name
}

module "eks" {
  source             = "./eks"
  environment        = var.environment
  cluster_name       = var.cluster_name
  cluster_role_arn   = module.iam.cluster_role_arn
  node_role_arn      = module.iam.node_role_arn
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  instance_types     = var.instance_types
}

# --- Kubernetes & Helm Resources ---

# 1. Metrics Server (Required for HPA autoscaling)
resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"

  depends_on = [module.eks]
}

# 2. Prometheus & Grafana (kube-prometheus-stack)
resource "helm_release" "prometheus" {
  name             = "prometheus-community"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  set {
    name  = "grafana.adminPassword"
    value = "admin123" # Recommended to change in production
  }

  depends_on = [module.eks]
}

# 3. AWS Load Balancer Controller Service Account
resource "kubernetes_service_account" "aws_lbc" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam.aws_lbc_role_arn
    }
  }

  depends_on = [module.eks]
}

# 4. AWS Load Balancer Controller Helm deployment
resource "helm_release" "aws_lbc" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  depends_on = [module.eks, kubernetes_service_account.aws_lbc]
}
