resource "aws_lb" "current" {
  name               = "${var.service_name}-lb"
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.alb.id ]
  subnets            = data.aws_subnet_ids.public.ids
  enable_deletion_protection = false
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.current.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.target_group.id
    type             = "forward"
  }
}

resource "aws_alb_target_group" "target_group" {
  name = "${var.service_name}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.main.id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}
