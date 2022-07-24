resource "helm_release" "external_dns" {
  
  depends_on = [
    module.eks
  ]
  
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  
  namespace = var.external_dns_namespace
  create_namespace = true

  set {
    name  = "provider"
    value = "aws"
  }
  set {
    name  = "domainFilters[0]"
    value = "${var.aws_hosted_zone_name}"
  }
  set {
    name  = "policy"
    value = "sync"
  }
  set {
    name  = "registry"
    value = "txt"
  }
  set {
    name  = "txtOwnerId"
    value = "${data.aws_route53_zone.mydomain.zone_id}"
  }
  set {
    name  = "aws.zoneType"
    value = "public"
  }
  set {
    name  = "interval"
    value = "3m"
  }
  set {
    name  = "rbac.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.name"
    value = "${var.iam_role_external_dns}"
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${module.iam_role_external_dns.iam_role_arn}"
  }

  wait = true
  
}