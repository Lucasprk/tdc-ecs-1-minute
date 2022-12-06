resource "aws_launch_template" "launch_template" {
  name                      = var.name
  description               = var.description
  image_id                  = var.ami
  instance_type             = var.instance_type
  vpc_security_group_ids    = var.sg_ids
  key_name                  = var.key
  update_default_version    = var.update_version_flag
  user_data                 = var.user_data

  dynamic "iam_instance_profile" {
    for_each = var.instance_profile_enabled ? toset([var.instance_profile_role_arn]) : toset([])
    content {
      arn = var.instance_profile_role_arn
    }
  }

  tags = var.tags
}