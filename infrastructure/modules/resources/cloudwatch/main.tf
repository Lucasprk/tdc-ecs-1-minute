resource "aws_cloudwatch_log_group" "log_group" {
  name                = var.log_group_name
  retention_in_days   = var.log_retention_in_days

  tags = {
    Environment = var.environment
    Application = var.application
  }
}