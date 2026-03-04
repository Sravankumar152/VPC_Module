data "aws_vpc" "default" {
 default = true
}

data "aws_caller_identity" "current" {}

data "aws_route_table" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "association.main"
    values = ["true"]
  }
}