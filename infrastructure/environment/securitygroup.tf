module "backends_apps_ec2_sg"{
  source          = "../modules/resources/sg"
  environment     = var.environment
  sg_name         = "${var.environment}-ec2-backends-apps-sg"
  sg_description  = "Backend Application EC2 Instances Security Group"
  sg_vpc_id       = var.vpc_id
}

module "backends_apps_ec2_sgr_outbound_all" {
  source                  = "../modules/resources/sg-rule"
  sgr_security_group_name = module.backends_apps_ec2_sg.security_group_name
  sgr_type                = "egress"
  sgr_from_port           = 0
  sgr_to_port             = 0
  sgr_ipv4                = local.sg_rule_all_ip
  sgr_protocol            = "all"

  depends_on = [module.backends_apps_ec2_sg]
}

module "backends_apps_ec2_sgr_ssh" {
  source                  = "../modules/resources/sg-rule"
  sgr_security_group_name = module.backends_apps_ec2_sg.security_group_name
  sgr_type                = "ingress"
  sgr_from_port           = 22
  sgr_to_port             = 22
  sgr_ipv4                = local.sg_rule_all_ip
  sgr_protocol            = "tcp"

  depends_on = [module.backends_apps_ec2_sg]
}

module "backends_apps_ec2_sgr_apps" {
  source                  = "../modules/resources/sg-rule"
  sgr_security_group_name = module.backends_apps_ec2_sg.security_group_name
  sgr_type                = "ingress"
  sgr_from_port           = 32768
  sgr_to_port             = 61000
  sgr_ipv4                = local.sg_rule_all_ip
  sgr_protocol            = "tcp"

  depends_on = [module.backends_apps_ec2_sg]
}

module "backends_apps_ec2_udp_sgr_apps" {
  source                  = "../modules/resources/sg-rule"
  sgr_security_group_name = module.backends_apps_ec2_sg.security_group_name
  sgr_type                = "ingress"
  sgr_from_port           = 32768
  sgr_to_port             = 61000
  sgr_ipv4                = local.sg_rule_all_ip
  sgr_protocol            = "udp"

  depends_on = [module.backends_apps_ec2_sg]
}

module "backends_apps_ec2_udp_sgr_apps_egress" {
  source                  = "../modules/resources/sg-rule"
  sgr_security_group_name = module.backends_apps_ec2_sg.security_group_name
  sgr_type                = "egress"
  sgr_from_port           = 32768
  sgr_to_port             = 61000
  sgr_ipv4                = local.sg_rule_all_ip
  sgr_protocol            = "udp"

  depends_on = [module.backends_apps_ec2_sg]
}

////////////////////////////////////////////////////////////
// BACKEND APPLICATIONS - ALB - SECURITY GROUP
////////////////////////////////////////////////////////////
module "general_apps_alb_sg"{
  source          = "../modules/resources/sg"
  environment     = var.environment
  sg_name         = "${var.environment}-alb-general-apps-sg"
  sg_description  = "General Apps ALB Security Group"
  sg_vpc_id       = var.vpc_id
}

module "general_apps_alb_sgr_http" {
  source                  = "../modules/resources/sg-rule"
  sgr_security_group_name = module.general_apps_alb_sg.security_group_name
  sgr_type                = "ingress"
  sgr_from_port           = 80
  sgr_to_port             = 80
  sgr_ipv4                = local.sg_rule_all_ip
  sgr_protocol            = "tcp"

  depends_on = [module.general_apps_alb_sg]
}

module "general_apps_alb_sgr_https" {
  source                  = "../modules/resources/sg-rule"
  sgr_security_group_name = module.general_apps_alb_sg.security_group_name
  sgr_type                = "ingress"
  sgr_from_port           = 443
  sgr_to_port             = 443
  sgr_ipv4                = local.sg_rule_all_ip
  sgr_protocol            = "tcp"

  depends_on = [module.general_apps_alb_sg]
}

module "general_apps_alb_sgr_outbound_all" {
  source                  = "../modules/resources/sg-rule"
  sgr_security_group_name = module.general_apps_alb_sg.security_group_name
  sgr_type                = "egress"
  sgr_from_port           = 0
  sgr_to_port             = 0
  sgr_ipv4                = local.sg_rule_all_ip
  sgr_protocol            = "all"

  depends_on = [module.general_apps_alb_sg]
}