provider "aws" {
  access_key = var.v-access-key
  secret_key = var.v-secret-key
  region     = var.region
}

resource "aws_vpc" "bgapp-vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "BGAPP-VPC"
  }
}

resource "aws_internet_gateway" "bgapp-igw" {
  vpc_id = aws_vpc.bgapp-vpc.id
  tags = {
    Name = "BGAPP-IGW"
  }
}

resource "aws_route_table" "bgapp-prt" {
  vpc_id = aws_vpc.bgapp-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bgapp-igw.id
  }
  tags = {
    Name = "BGAPP-PUBLIC_RT"
  }
}

resource "aws_subnet" "bgapp-snet" {
  vpc_id                  = aws_vpc.bgapp-vpc.id
  cidr_block              = "10.10.10.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "BGAPP-SUB-NET"
  }
}

resource "aws_route_table_association" "bgapp-prt-assoc" {
  subnet_id      = aws_subnet.bgapp-snet.id
  route_table_id = aws_route_table.bgapp-prt.id
}

resource "aws_security_group" "bgapp-pub-sg" {
  name        = "bgapp-pub-sg"
  description = "bgapp Public SG"
  vpc_id      = aws_vpc.bgapp-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
