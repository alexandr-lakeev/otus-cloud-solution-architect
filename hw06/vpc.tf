#resource "aws_vpc" "vpc" {
#  cidr_block = "10.10.0.0/16"
#  enable_dns_support = true
#  enable_dns_hostnames = true
#
#  tags = {
#    Name = "my-vpc"
#  }
#}
#
#resource "aws_subnet" "app_subnet" {
#  vpc_id            = aws_vpc.vpc.id
#  cidr_block        = "10.10.1.0/24"
#  availability_zone = "eu-central-1a"
#
#  tags = {
#    Name = "app-subnet-a"
#  }
#}
