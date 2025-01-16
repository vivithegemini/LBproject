resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
}

#create the internet gateway
resource "aws_internet_gateway" "albgateway" {
  vpc_id = aws_vpc.vpc1.id
}

#elastic ip
resource "aws_eip" "eip1" {}

#create the nat gateway
resource "aws_nat_gateway" "albnat" {
  allocation_id = aws_eip.eip1.id
  subnet_id = aws_subnet.public1.id
}

# create private subnet
resource "aws_subnet" "private1" {
    availability_zone = "us-east-1a"
    vpc_id = aws_vpc.vpc1.id
    cidr_block =  "10.0.1.0/24"
  
}
resource "aws_subnet" "private2" {
    availability_zone = "us-east-1b"
    vpc_id = aws_vpc.vpc1.id
    cidr_block =  "10.0.2.0/24"
  
}
# create a public subnet
resource "aws_subnet" "public1" {
    availability_zone = "us-east-1a"
    vpc_id = aws_vpc.vpc1.id
    cidr_block =  "10.0.3.0/24"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "public2" {
    availability_zone = "us-east-1b"
    vpc_id = aws_vpc.vpc1.id
    cidr_block =  "10.0.4.0/24"
    map_public_ip_on_launch = true
}

#create route table
#public
resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.albgateway.id
  }
}
#private
resource "aws_route_table" "route2" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.albnat.id
  }
}

#create route table association public

resource "aws_route_table_association" "pub1" {
  subnet_id = aws_subnet.public1.id
  route_table_id = aws_route_table.route1.id
}

resource "aws_route_table_association" "pub2" {
  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.route1.id
}

#create route table association private

resource "aws_route_table_association" "priv1" {
  subnet_id = aws_subnet.private1.id
  route_table_id = aws_route_table.route1.id
}

resource "aws_route_table_association" "priv2" {
  subnet_id = aws_subnet.private2.id
  route_table_id = aws_route_table.route1.id
}

