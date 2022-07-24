# AWS Load Balancer Controller must be installed to take care of the Services and Ingresses
# It creates NLB for LoadBalancer and ALB for Ingress
resource "helm_release" "aws-load-balancer-controller" {
  
  depends_on = [
    module.eks
  ]
  
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  
  namespace = var.aws_lb_namespace

  set {
    name  = "clusterName"
    value = local.eks_cluster_name
  }
  set {
    name  = "serviceAccount.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.name"
    value = var.aws_lb_service_account
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${module.iam_role_aws_lb_controller.iam_role_arn}"
  }
  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.${var.aws_region}.amazonaws.com/amazon/aws-load-balancer-controller"
  }

  wait = true
  
}