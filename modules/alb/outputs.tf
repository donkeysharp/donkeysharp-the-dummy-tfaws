output "alb_id" {
  value = aws_lb.alb.id
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "dns_name" {
  value = aws_lb.alb.dns_name
}

output "zone_id" {
  value = aws_lb.alb.zone_id
}

output "http_listener_id" {
  value = aws_lb_listener.http_listener.id
}

output "http_listener_arn" {
  value = aws_lb_listener.http_listener.arn
}

output "https_listener_id" {
  value = aws_lb_listener.https_listener.id
}

output "https_listener_arn" {
  value = aws_lb_listener.https_listener.arn
}
