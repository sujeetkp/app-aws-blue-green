module "aws_lb_iam_policy" {

  depends_on = [
    module.eks
  ]
  
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.2.0"

  name        = var.aws_lb_iam_policy_name
  path        = "/"
  description = "AWS LB Controller Policy"

  policy = file("config-files/aws_lb_iam_policy.json")

}

output "aws_lb_iam_policy_arn" {
  value = module.aws_lb_iam_policy.arn
}