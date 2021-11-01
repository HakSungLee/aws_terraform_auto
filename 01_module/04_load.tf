#12
# Application LoadBalancer Deploy
resource "aws_lb" "simon_lb" {
  name                   = "${var.name}-alb"
  internal               = var.lb_internal  //false
  load_balancer_type     = var.lb_type      //"application"
  security_groups        = [aws_security_group.simon_websg.id]
  subnets                = [aws_subnet.simon_pub[0].id,aws_subnet.simon_pub[1].id]
  
  tags = {
    Name  = "${var.name}-alb"
  }
}

#13
resource "aws_lb_target_group" "simon_lbtg" {
  name      = "${var.name}-lbtg"
  port      =  var.http_port        // 80
  protocol  =  var.port_http        // "HTTP"
  vpc_id    =  aws_vpc.simon_vpc.id

  health_check {
    enabled               = var.enabled             // true
    healthy_threshold     = var.healthy_threshold   // 3
    interval              = var.interval            // 5
    matcher               = var.matcher             // "200"
    path                  = var.path                //"/health.html"
    port                  = var.health_port         //"traffic-port"
    protocol              = var.port_http           // "HTTP"
    timeout               = var.timeout             //2
    unhealthy_threshold   = var.unhealthy_threshold //2
  }
}

#14
resource "aws_lb_listener" "simon_lblist" {
  load_balancer_arn       = aws_lb.simon_lb.arn
  port                    = var.http_port //80
  protocol                = var.port_http // "HTTP"

  default_action {
    type                  = "forward"
    target_group_arn      = aws_lb_target_group.simon_lbtg.arn  
  }
}
#15
resource "aws_lb_target_group_attachment" "simon_lbtg_att" {
  target_group_arn      = aws_lb_target_group.simon_lbtg.arn
  target_id             = aws_instance.simon_weba.id
  port                  = var.http_port
}