locals {
    oidc_arn = module.eks.oidc_provider_arn
    provider_url = element(split("provider/", local.oidc_arn),1)
}   