resource "aws_acm_certificate" "cert" {
  validation_method = "DNS"
  domain_name       = var.domain
  subject_alternative_names = var.alternative_domains

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-acm-certificate"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count   = length(var.alternative_domains) + 1

  ttl     = 60
  name    = aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_type
  zone_id = var.domain_zone_id
  records = [aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_value]
  allow_overwrite = true
}
