data "aws_vpc" "default" {
 default = true
  filter {
    name   = "association main"
    values = ["true"]
  }
}
