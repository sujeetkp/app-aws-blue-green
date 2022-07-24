resource "helm_release" "prometheus-adapter" {
  
  depends_on = [
    module.eks,
    helm_release.prometheus-operator
  ]

  name       = "prometheus-adapter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-adapter"
  
  namespace = "default"

  values = [
    "${file("config-files/prometheus-adapter-values.yml")}"
  ]

  wait = true
  
}