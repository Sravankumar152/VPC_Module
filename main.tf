resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = local.vpc_tags
}


resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.main.id

  tags = local.ig_final_tags
}


resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.environment}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-private-${count.index + 1}"
  }
}


resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-database-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-${var.environment}-public-routetable"
  }

}

resource "aws_route" "public_internet" {

  route_table_id = aws_route_table.public.id
  destination_cidr_block = var.public_cidr_dest
  gateway_id = aws_internet_gateway.IG.id
  
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}