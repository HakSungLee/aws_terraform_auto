#10
resource "aws_security_group" "simon_websg" {
  name        = "Allow-WEB"
  description = "http-ssh-icmp"
  vpc_id      = aws_vpc.simon_vpc.id

  ingress = [
    {
      description       = var.port_ssh
      from_port         = var.ssh_port
      to_port           = var.ssh_port
      protocol          = var.port_tcp
      cidr_blocks       = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr6]
      security_groups   =  null
      prefix_list_ids   =  null
      self              =  null
    },
    {
      description     = var.port_http
      from_port       = "${var.http_port}"
      to_port         = var.http_port
      protocol        = var.port_tcp
      cidr_blocks      = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr6]
      security_groups  =  null
      prefix_list_ids  =  null
      self             =  null
    },
    {
      description     = var.port_icmp
      from_port       = var.under_port
      to_port         = var.under_port
      protocol        = var.port_icmp
      cidr_blocks      = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr6]
      security_groups  =  null
      prefix_list_ids  =  null
      self             =  null
    },
    {
      description     = var.port_mysql
      from_port       = var.mysql_port
      to_port         = var.mysql_port
      protocol        = "tcp"
      cidr_blocks      = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr6]
      security_groups  =  null
      prefix_list_ids  =  null
      self             =  null
    }
  ]

   egress = [
     {
      description     = "All"
      from_port        = 0
      to_port          = 0
      protocol         = var.under_port
      cidr_blocks      = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr6]
      security_groups  =  null
      prefix_list_ids  =  null
      self             =  null
    }
   ]
  tags = {
    Name = "${var.name}-sg"
  }
} 


# 11
data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "simon_weba" {
  ami                    = data.aws_ami.amzn.id //"ami-0e4a9ad2eb120e054"                             #data.aws_ami.amzn.id
  instance_type          = var.instance_type
  key_name               = var.key //"simon-key"
  vpc_security_group_ids = [aws_security_group.simon_websg.id]
  availability_zone      = "${var.region}${var.avazone[0]}"//"ap-northeast-2a"
  private_ip             = var.private_ip//"10.0.0.11"
  subnet_id              = aws_subnet.simon_pub[0].id
  user_data              = file("./install_seoul.sh") 

  tags = {
    Name = "${var.name}-weba"
  }
}
resource "aws_eip" "simon_web_eip" {
  vpc = true
  instance                    = aws_instance.simon_weba.id
  associate_with_private_ip   = var.private_ip//"10.0.0.11"
  depends_on                  = [aws_internet_gateway.simon_ig]
}