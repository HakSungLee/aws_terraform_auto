# NAME
variable "name"{
    type = string
    #default = "simon"
}

variable "region"{
    type =string
    #default = "ap-northeast-2"
}

variable "key"{
    type = string
    #default = "simon-key"
}

##################################### vpc subnet #####################
variable "cidr"{
    type = string
    #default = "0.0.0.0/0"
}

variable "cidr_main"{
    type = string
    #default = "10.0.0.0/16"
}

variable "public_s"{
    type = list
    #default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "private_s"{
    type = list
    #default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_dbs"{
    type = list
   # default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "avazone"{
    type = list
    #default = ["a", "c"]
}

variable "private_ip"{
    type = string
    #default = "192.168.0.11"
}
##################################### security group############
variable "ssh_port"{
    type = string
    #default = "22"
}

variable "http_port"{
    type = string
    #default = "80"
}

variable "cidr6"{
    type = string
    #default = ""::/0""
}

variable "mysql_port"{
    type = string
    #default = "3306"
}
variable "port_ssh"{
    type = string
    #default = "ssh"
}

variable "port_http"{
    type = string
    #default = ""
}

variable "port_tcp"{
    type = string
    #default = ""
}

variable "port_icmp"{
    type = string
    #default = ""
}

variable "under_port"{
    type = string
    #default = "-1"
}

variable "port_mysql"{
    type = string
    #default = "mysql"
}
##################################### load balance ###############
variable "instance_type"{
    type = string
    #default = "t2.micro"
}

variable "lb_internal"{
    type = bool
    #default = "false"
}

variable "lb_type"{
    type = string
    #default = "application"
}

################################## lb health check
variable "enabled"{
    type = bool
    #default = true
}
variable "healthy_threshold"{
    type = number
    #default = 3
}
variable "interval"{
    type = number
    #default = 5
}
variable "matcher"{
    type = string
    #default = "200"
}
variable "path"{
    type = string
    #default = "health.html"
}
variable "health_port"{
    type = string
    #default = "trafic-port"
}

variable "timeout"{
    type = number
    #default = 2
}
variable "unhealthy_threshold"{
    type = number
    #default = 2
}

################################ auto group ################
variable "auto_min_size"{
    type = number
    #default = 2
}
variable "auto_max_size"{
    type = number
    #default = 8
}
variable "auto_health_check_grace_period"{
    type = number
    #default = 300
}
variable "auto_health_check_type"{
    type = string
    #default = "ELB"
}
variable "auto_desired_capacity"{
    type = number
    #default = 2
}

variable "auto_force_delete"{
    type = bool
    #default = true
}

############################# DB #############################
variable "db_allocated_storage"{
    type = number
    #default = 20
}
variable "db_storage_type"{
    type = string
    #default = "gp2"
}
variable "db_engine"{
    type = string
    #default = "mysql"
}
variable "db_engine_version"{
    type = string
    #default = "8.0"
}
variable "db_instance_class"{
    type = string
    #default = "db.t2.micro"
}
variable "db_name"{
    type = string
    #default = "mydb"
}
variable "db_identifier"{
    type = string
    #default = "mydb"
}
variable "db_username"{
    type = string
    #default = "admin"
}
variable "db_password"{
    type = string
    #default = "It12345!"
}
variable "db_parameter_group_name"{
    type = string
    #default = "default.mysql8.0"
}
variable "db_skip_final_snapshot"{
    type = bool
    #default = true
}


/*
variable ""{
    type = string
    #default = ""
}

*/

