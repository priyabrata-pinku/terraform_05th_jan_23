provider "aws" {}

variable "cidr_blocks" {
    description = "cidr blocks for vpc and subnet"
    type = list(object({
        cidr_block = string
        name = string
    }))
}

variable "avail_zone" {}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
      "Name" = var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = var.avail_zone
  tags = {
    "Name" = var.cidr_blocks[1].name
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "default-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "subnet-2-default"
  }
}


output "dev_vpc_id" {
    value = aws_subnet.dev-subnet-1.id
}

output "default_subnet_id" {
    value = aws_subnet.default-subnet-2.id
}

output "dev_subnet_id" {
    value = aws_subnet.dev-subnet-1.id
}
