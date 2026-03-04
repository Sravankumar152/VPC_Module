data "aws_vpc" "default" {
 default = true
}

data "aws_caller_identity" "current" {}