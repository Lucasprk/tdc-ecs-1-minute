resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.alb_arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  tags = {
    "Environment": var.environment
  }
}