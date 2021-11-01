provider "aws" {
  region  = var.region//"ap-northeast-2"  
}

resource "aws_key_pair" "simon_key" {
  key_name        = var.key//"simon-key"
  public_key      = file("../../../.ssh/id_rsa.pub")  
}

resource "aws_vpc" "simon_vpc" {
  cidr_block = var.cidr_main //"10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
      Name   =  "${var.name}-vpc"  //simon-vpc
      NAme   = var.name
      Name    = "var.name-vpc"
  }
}

# public subnet
resource "aws_subnet" "simon_pub" {
  vpc_id            = aws_vpc.simon_vpc.id
  count             = "${length(var.public_s)}" // 2
  cidr_block        = "${var.public_s[count.index]}"
  availability_zone = "${var.region}${var.avazone[count.index]}"

  tags = {
    Name = "pub-${var.avazone[count.index]}"
  }
}

# Private Subnet
resource "aws_subnet" "simon_pri" {
  vpc_id            = aws_vpc.simon_vpc.id
  count             = "${length(var.private_s)}" // 2
  cidr_block        = "${var.private_s[count.index]}"
  availability_zone = "${var.region}${var.avazone[count.index]}"
  tags = {
    Name = "pri-${var.avazone[count.index]}"
  }
}

# db subnet
resource "aws_subnet" "simon_pridb" {
  vpc_id            = aws_vpc.simon_vpc.id
  count             = "${length(var.private_dbs)}" // 2
  cidr_block        = "${var.private_dbs[count.index]}"
  availability_zone = "${var.region}${var.avazone[count.index]}"
  tags = {
    Name = "pri-db-${var.avazone[count.index]}"
  }
}

# 04 ingernet gateway
resource "aws_internet_gateway" "simon_ig" {
  vpc_id = aws_vpc.simon_vpc.id

  tags = {
    Name = "${var.name}-ig"
  }
}

# 05
resource "aws_route_table" "simon_rt" {
  vpc_id = aws_vpc.simon_vpc.id

  route {
  #  carrier_gateway_id = "value"
    cidr_block = var.cidr
  #  destination_prefix_list_id = "value"
  #  egress_only_gateway_id = "value"
    gateway_id = aws_internet_gateway.simon_ig.id
  #  instance_id = "value"
  #  ipv6_cidr_block = "value"
  #  local_gateway_id = "value"
  #  nat_gateway_id = "value"
  #  network_interface_id = "value"
  #  transit_gateway_id = "value"
  #  vpc_endpoint_id = "value"
  #  vpc_peering_connection_id = "value"
  } 
  tags = {
    Name = "${var.name}-rt"
  }
}

# 06 route table association
resource "aws_route_table_association" "simon_rtas_a" {
  count             = "${length(var.public_s)}" // 2
  subnet_id         = aws_subnet.simon_pub[count.index].id
  route_table_id     = aws_route_table.simon_rt.id
}
