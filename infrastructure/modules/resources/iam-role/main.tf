resource "aws_iam_role" "iam_role" {
  name = var.role_name

  description           = var.role_description
  assume_role_policy    = var.assume_role_policy
  managed_policy_arns   = var.managed_policy_arn_list
}