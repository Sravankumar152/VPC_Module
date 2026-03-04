resource "aws_vpc_peering_connection" "main" {
  peer_owner_id = data.aws_caller_identity.current.id
  peer_vpc_id   = data.aws_vpc.default.id
  vpc_id        = aws_vpc.main.id
  auto_accept   = true

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

tags = merge(
    local.commontags,
    {
        Name = "${var.project}-${var.environment}-default"
    }
    
)


}

resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.public_cidr_dest
  vpc_peering_connection_id  = aws_vpc_peering_connection.default[count.index].id
}

resource "aws_route" "private_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  vpc_peering_connection_id  = aws_vpc_peering_connection.main[count.index].id
}

resource "aws_route" "database_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  vpc_peering_connection_id  = aws_vpc_peering_connection.main[count.index].id
}

resource "aws_route" "default_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = data.aws_route_table.default.id
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id  = aws_vpc_peering_connection.main[count.index].id
}
