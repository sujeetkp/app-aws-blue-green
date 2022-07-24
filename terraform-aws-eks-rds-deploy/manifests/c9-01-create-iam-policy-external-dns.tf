module "iam_policy" {

  depends_on = [
    module.eks
  ]
  
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.2.0"

  name        = var.iam_policy_name
  path        = "/"
  description = "External DNS and Cert Manager Policy"

  policy = file("config-files/external-dns-iam-policy.json")

}

output "iam_policy_arn" {
  value = module.iam_policy.arn
}