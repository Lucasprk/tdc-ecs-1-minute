resource "aws_lb" "alb" {
  name              = var.alb_name
  internal          = var.is_internal
  subnets           = var.subnet_ids
  security_groups   = var.security_group_ids

  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = var.http_port
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      status_code  = 503
      content_type = "text/plain"
    }
  }
}