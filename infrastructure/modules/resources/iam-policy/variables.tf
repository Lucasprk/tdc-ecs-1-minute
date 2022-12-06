variable "name" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The name of the policy. If omitted, Terraform will assign a random, unique name."
}

variable "description" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) Description of the IAM policy."
}

variable "policy" {
  type        = string
  description = "(Required) The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide"
}

