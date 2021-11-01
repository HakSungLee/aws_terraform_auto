resource "aws_db_instance" "simon_mydb" {
  allocated_storage       = var.db_allocated_storage    //20
  storage_type            = var.db_storage_type         //"gp2"
  engine                  = var.db_engine               //"mysql"
  engine_version          = var.db_engine_version       //"8.0"
  instance_class          = var.db_instance_class       //"db.t2.micro"
  name                    = var.db_name                 //"mydb"
  identifier              = var.db_identifier           //"mydb"
  username                = var.db_username             //"admin"
  password                = var.db_password             //"It12345!"
  parameter_group_name    = var.db_parameter_group_name         //"default.mysql8.0"
  availability_zone       = "${var.region}${var.avazone[0]}"    //"ap-northeast-2a"
  db_subnet_group_name    = aws_db_subnet_group.simon_dbsn.id
  vpc_security_group_ids  = [aws_security_group.simon_websg.id]
  skip_final_snapshot     = var.db_skip_final_snapshot          //true
  tags = {
      Name = "${var.name}-mydb"
  }
}

resource "aws_db_subnet_group" "simon_dbsn" {
  name  =   "${var.name}-dbsb-group"
  subnet_ids = [aws_subnet.simon_pridb[0].id,aws_subnet.simon_pridb[1].id]
  tags = {
      Name = "${var.name}-dbsb-group"
  }
}