module "iam_role_aws_lb_controller" {

  depends_on = [
    module.aws_lb_iam_policy
  ]
  
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.2.0"

  create_role = true

  role_name = var.iam_role_aws_lb

  provider_url = local.provider_url

  role_policy_arns = [module.aws_lb_iam_policy.arn]

  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.aws_lb_namespace}:${var.aws_lb_service_account}"]

  oidc_fully_qualified_audiences = ["sts.amazonaws.com"]
  
}

output "aws_lb_role_arn" {
  value = module.iam_role_aws_lb_controller.iam_role_arn
}