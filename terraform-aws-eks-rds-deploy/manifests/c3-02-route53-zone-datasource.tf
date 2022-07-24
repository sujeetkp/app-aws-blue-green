# Get the Rout53 Hosted Zone(Domain) Details
data "aws_route53_zone" "mydomain" {
  name         = var.aws_hosted_zone_name
  private_zone = false
}

#Outputs
output "mydomain_zoneid" {
  description = "Hested Zone ID for my domain"
  value = data.aws_route53_zone.mydomain.zone_id
}

output "mydomain_name" {
  description = "Domain Name for my domain"
  value = data.aws_route53_zone.mydomain.name
}