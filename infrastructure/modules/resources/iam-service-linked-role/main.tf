resource "aws_iam_service_linked_role" "service_linked_role" {
  aws_service_name = var.aws_service_name

  lifecycle {
    ignore_changes = [description, custom_suffix]
  }
}