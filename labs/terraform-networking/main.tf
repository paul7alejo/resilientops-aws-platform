terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "resilientops" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "resilientops-vpc"
    Project     = "ResilientOps"
    Environment = "learning"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.resilientops.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "resilientops-public-subnet"
    Tier = "public"
  }
}

resource "aws_subnet" "private_app" {
  vpc_id            = aws_vpc.resilientops.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "resilientops-private-app-subnet"
    Tier = "private"
  }
}
resource "aws_internet_gateway" "resilientops" {
  vpc_id = aws_vpc.resilientops.id

  tags = {
    Name = "resilientops-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.resilientops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.resilientops.id
  }

  tags = {
    Name = "resilientops-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}