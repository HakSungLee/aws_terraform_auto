# 07 nga.tf
resource "aws_eip" "lb_ip" {
#  instance = aws_instance.web.id
  vpc      = true
}

resource "aws_nat_gateway" "simon_nga" {
  //count = 2 nat gateway는 하나만 만들어도 되서
  allocation_id = aws_eip.lb_ip.id
  subnet_id     = aws_subnet.simon_pub[0].id
  tags = {
    Name = "${var.name}-nga"
  }
}

# 08
resource "aws_route_table" "simon_ngart" {
  vpc_id  =  aws_vpc.simon_vpc.id
  route {
    cidr_block  = var.cidr //"0.0.0.0/0"
    gateway_id  = aws_nat_gateway.simon_nga.id
  }
  tags  = {
    Name  = "${var.name}-nga-rta"
  }
}


# 09
resource "aws_route_table_association" "simon_ngartas" {
  //count = 2
  subnet_id      = aws_subnet.simon_pri[0].id //aws_subnet.simon_pria.id
  route_table_id = aws_route_table.simon_ngart.id
}
