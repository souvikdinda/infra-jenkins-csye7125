# Creating a VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  #enable_dns_support = true
  #enable_dns_hostnames = true

  tags = {
    Name = "Main VPC"
  }
}

#Creating public subnet
resource "aws_subnet" "public-subnets" {
  count                   = min(length(data.aws_availability_zones.available_zones.names), 1)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index * 2 + 1)
  availability_zone       = element(data.aws_availability_zones.available_zones.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# creating Internet Gateway for VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main IGW"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.publicroutetablecidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Association between Public Subnet 1 and Public Route Table
resource "aws_route_table_association" "public" {
  count          = min(length(data.aws_availability_zones.available_zones.names), 1)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
