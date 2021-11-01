# 16 ami
resource "aws_ami_from_instance" "simon_ami" {
  name                    = "${var.name}-ami" //simon-ami
  source_instance_id      = aws_instance.simon_weba.id
  depends_on = [
    aws_instance.simon_weba
  ]
}

#17
resource "aws_launch_configuration" "simon_lacf" {
  name                 = "${var.name}-web"  //simon-web
  image_id             = aws_ami_from_instance.simon_ami.id
  instance_type        = var.instance_type  //t2.micro
  iam_instance_profile = "admin_role"
  security_groups      = [aws_security_group.simon_websg.id]
  key_name             = var.key            //"simon-key"
  user_data            =<<-EOF
                        #!/bin/bash
                        systemctl start httpd
                        systemctl enable httpd
                        EOF
  lifecycle {
    create_before_destroy  = true
  }
}

#18
resource "aws_placement_group" "simon_pg" {
  name     = "${var.name}-pg"     //simon-pg
  strategy = "cluster"
}

resource "aws_autoscaling_group" "simon_atsg" {
  name                      = "${var.name}-atsg"
  min_size                  = var.auto_min_size                    //2
  max_size                  = var.auto_max_size                    //8
  health_check_grace_period = var.auto_health_check_grace_period   //300
  health_check_type         = var.auto_health_check_type           //"ELB"
  desired_capacity          = var.auto_desired_capacity            //2
  force_delete              = var.auto_force_delete                //true
  launch_configuration      = aws_launch_configuration.simon_lacf.name
  vpc_zone_identifier       = [aws_subnet.simon_pub[0].id,aws_subnet.simon_pub[1].id]
}
#19
resource "aws_autoscaling_attachment" "simon_atatt" {
  autoscaling_group_name = aws_autoscaling_group.simon_atsg.id
  alb_target_group_arn   = aws_lb_target_group.simon_lbtg.arn
}