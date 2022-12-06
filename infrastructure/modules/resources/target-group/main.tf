resource "aws_lb_target_group" "target_group" {
  name      = var.tg_name
  protocol  = var.tg_protocol
  port      = var.application_port
  vpc_id    = var.vpc_ids

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    path                = var.health_check_path
    interval            = var.interval
    matcher             = var.matcher
    port                = var.health_check_port
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [name]
  }
}

