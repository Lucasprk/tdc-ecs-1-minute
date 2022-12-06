data "aws_security_group" "security_group" {
  name = var.sgr_security_group_name
}


resource "aws_security_group_rule" "self_rule" {
  type              = var.sgr_type
  from_port         = var.sgr_from_port
  to_port           = var.sgr_to_port
  protocol          = var.sgr_protocol
  security_group_id = data.aws_security_group.security_group.id
  self              = true
}