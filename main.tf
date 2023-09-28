# Creating a VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Jenkins VPC"
  }
}

#Creating public subnet
resource "aws_subnet" "public-subnets" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(data.aws_availability_zones.available_zones.names, 0)
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  map_public_ip_on_launch = true
  tags = {
    Name = "Jenkins Public Subnet"
  }
}

# creating Internet Gateway for VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Jenkins Internet Gateway"
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
    Name = "Jenkins Public Route Table"
  }
}

# Association between Public Subnet 1 and Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public-subnets.id
  route_table_id = aws_route_table.public_route_table.id
}


