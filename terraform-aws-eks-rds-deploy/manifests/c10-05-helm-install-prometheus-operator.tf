resource "helm_release" "prometheus-operator" {
  
  depends_on = [
    module.eks
  ]

  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  
  namespace = "default"

  wait = true
  timeout = 600
  
}