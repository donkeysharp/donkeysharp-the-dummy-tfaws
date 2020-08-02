
/**
 * Outputs for vpc
 */
output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_arn" {
  value = aws_vpc.vpc.arn
}

output "vpc_owner" {
  value = aws_vpc.vpc.owner_id
}

/**
 * Outputs for subnets
 */
output "public_subnet_ids" {
  value = aws_subnet.public_subnets.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets.*.id
}

/**
 * Outputs for internet gateway
 */
output "internetgw_id"  {
  value = aws_internet_gateway.internetgw.id
}

output "internetgw_arn"  {
  value = aws_internet_gateway.internetgw.arn
}

/**
 * Outputs for NAT instance
 */
output "nat_instance_sg_id"  {
  value = aws_security_group.nat_instance_sg.id
}

output "nat_instance_id"  {
  value = aws_instance.nat_instance.id
}

output "nat_instance_public_ip"  {
  value = var.nat_instance_eip == "" ? aws_eip.nat_eip[0].public_ip : ""
}
