output "certificate" {
  value = aws_acm_certificate.cert
}

output "certificate_id" {
  value = aws_acm_certificate.cert.id
}

output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}
