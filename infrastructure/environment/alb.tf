data "aws_subnet_ids" "default_subnet_ids" {
  vpc_id = var.vpc_id
}

module "general_apps_alb" {
  source              = "../modules/resources/lb"
  alb_name            = "${var.environment}-general-apps-alb"
  security_group_ids  = [module.general_apps_alb_sg.security_group_id]
  subnet_ids          = data.aws_subnet_ids.default_subnet_ids.ids
  is_internal         = false

  depends_on = [module.general_apps_alb_sg]
}