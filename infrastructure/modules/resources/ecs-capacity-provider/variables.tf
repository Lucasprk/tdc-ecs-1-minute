variable "name" {
  type = string
  description = "(Required) Name of the capacity provider."
}

variable "auto_scaling_group_arn" {
  type = string
  description = "(Required) - ARN of the associated auto scaling group."
}

variable "managed_termination_protection" {
  type = string
  default = "DISABLED"
  description = "(Optional) - Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens. Valid values are ENABLED and DISABLED."
}

variable "tags" {
  default = null
}