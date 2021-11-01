module "stage" {
  source = "../01_module"

  # NAME
  key         = "simon-key"
  name        = "simons"
  region      = "ap-northeast-1"
  # vpc, subnet data
  cidr        = "0.0.0.0/0"
  cidr_main   = "192.168.0.0/16"
  avazone     = ["a","c"]
  public_s    = ["192.168.0.0/24", "192.168.2.0/24"]
  private_s   = ["192.168.1.0/24", "192.168.3.0/24"]
  private_dbs = ["192.168.4.0/24", "192.168.5.0/24"]
  private_ip  = "192.168.0.11"
  
  # security group data 10
  ssh_port    = "22"
  http_port   = "80"
  cidr6       = "::/0"
  mysql_port  = "3306"
  port_http   = "HTTP"
  port_icmp   = "icmp"
  port_mysql  = "mysql"
  port_ssh    = "ssh"
  port_tcp    = "tcp"
  under_port  = "-1"
  
  # lb data 12
  instance_type = "t2.micro"
  lb_internal   = false
  lb_type       = "application"
  
  # lb health check data 13
  enabled               = true
  healthy_threshold     = 3
  interval              = 5
  matcher               = "200"
  path                  = "/health.html"
  health_port           = "traffic-port"
  timeout               = 2
  unhealthy_threshold   = 2

  # auto group 18
  auto_min_size                  = 2
  auto_max_size                  = 8
  auto_health_check_grace_period = 300
  auto_health_check_type         = "ELB"
  auto_desired_capacity          = 2
  auto_force_delete              = true

  # rds 20
  db_allocated_storage       = 20
  db_storage_type            = "gp2"
  db_engine                  = "mysql"
  db_engine_version          = "8.0"
  db_instance_class          = "db.t2.micro"
  db_name                    = "mydb"
  db_identifier              = "mydb"
  db_username                = "admin"
  db_password                = "It12345!"
  db_parameter_group_name    = "default.mysql8.0"
  db_skip_final_snapshot     = true

}