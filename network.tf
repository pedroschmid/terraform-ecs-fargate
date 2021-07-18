# VPC #
resource "aws_vpc" "this" {
  cidr_block           = var.VPC_CIDR_BLOCK
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "vpc-${var.ENVIRONMENT}"
  }
}

# Public subnets
resource "aws_subnet" "public" {
  count = length(var.PUBLIC_SUBNETS_CIDR)

  cidr_block        = element(var.PUBLIC_SUBNETS_CIDR, count.index)
  availability_zone = element(var.AVAILABILITY_ZONES, count.index)
  vpc_id            = aws_vpc.this.id

  tags = {
    "Name" = "public-subnet-${element(var.AVAILABILITY_ZONES, count.index)}-${var.ENVIRONMENT}"
  }
}

# Private subnets
resource "aws_subnet" "private" {
  count = length(var.PRIVATE_SUBNETS_CIDR)

  cidr_block        = element(var.PRIVATE_SUBNETS_CIDR, count.index)
  availability_zone = element(var.AVAILABILITY_ZONES, count.index)
  vpc_id            = aws_vpc.this.id

  tags = {
    "Name" = "private-subnet-${element(var.AVAILABILITY_ZONES, count.index)}-${var.ENVIRONMENT}"
  }
}