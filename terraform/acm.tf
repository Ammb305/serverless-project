data "aws_acm_certificate" "ssl_certificate" {
  domain   = var.domain
  statuses = ["ISSUED"]
}

resource "aws_api_gateway_domain_name" "domain" {
  domain_name              = var.domain
  regional_certificate_arn = data.aws_acm_certificate.ssl_certificate.arn
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}