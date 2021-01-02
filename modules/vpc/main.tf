resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-vpc"
    },
  )
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-public-subnet-${count.index}"
    },
  )
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-private-subnet-${count.index}"
    },
  )
}

resource "aws_internet_gateway" "internetgw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-internetgw"
    },
  )
}

resource "aws_security_group" "nat_instance_sg" {
  name        = "${module.prefix.id}-nat-instance-sg"
  description = "NAT instance security group"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-nat-instance-sg"
    },
  )
}

resource "aws_security_group_rule" "nat_instance_internal_access" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = concat(var.public_subnets_cidr, var.private_subnets_cidr)
  security_group_id = aws_security_group.nat_instance_sg.id
}

resource "aws_eip" "nat_eip" {
  count = var.nat_instance_eip == "" ? 1 : 0
  vpc   = true
  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-nat-eip"
    },
  )
}

resource "aws_instance" "nat_instance" {
  instance_type          = var.nat_instance_type
  ami                    = data.aws_ami.nat_vpc_ami.id
  key_name               = var.nat_instance_key_name
  vpc_security_group_ids = [aws_security_group.nat_instance_sg.id]
  source_dest_check      = false
  subnet_id              = aws_subnet.public_subnets[0].id
  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-nat-instance"
    },
  )

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}

resource "aws_eip_association" "nat_eip_assoc" {
  instance_id   = aws_instance.nat_instance.id
  allocation_id = var.nat_instance_eip != "" ? var.nat_instance_eip : aws_eip.nat_eip[0].id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-public-rt"
    },
  )
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-private-rt"
    },
  )
}

resource "aws_route_table_association" "public_subnets_route_table_assoc" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnets_route_table_assoc" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route" "public_routes" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internetgw.id
}

resource "aws_route" "private_routes" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = aws_instance.nat_instance.id
}
