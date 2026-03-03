variable "project" {

    type = string
  
}

variable "environment" {

    type = string
  
}

variable "cidr_block" {

    default = "10.0.0.0/16"
  
}

variable "public_subnet_cidr" {
  type = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidr" {
  type = list(string)

  default = [
    "10.0.12.0/24",
    "10.0.13.0/24"
  ]
}


variable "database_subnet_cidr" {
  type = list(string)

  default = [
    "10.0.21.0/24",
    "10.0.22.0/24"
  ]
}

variable "public_cidr_dest" {

    type = string
    default = "0.0.0.0/0"
  
}

variable "availability_zone" {

    type = list(string)
    default = ["us-east-1a", "us-east-1b"]
  
}


variable "ig_W" {

    default = {}
    type = map
  
}

variable "tags" {

    type = map(string)

    default = {
        Name = "Roboshop_aws_vpc"
        ig_W = "roboshop-gate-way"
    }
  
}


