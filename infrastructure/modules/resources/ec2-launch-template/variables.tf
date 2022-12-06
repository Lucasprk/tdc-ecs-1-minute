variable "name" {
  type        = string
  description = "The name of the launch template. If you leave this blank, Terraform will auto-generate a unique name."
}

variable "description" {
  type        = string
  description = "Description of the launch template."
}

variable "ami" {
  type        = string
  description = "The AMI from which to launch the instance."
}

variable "instance_type" {
  type        = string
  description = "The type of the instance."
}

variable "sg_ids" {
  type        = list
  description = "A list of security group names to associate with. If you are creating Instances in a VPC, use \"vpc_security_group_ids\" instead."
}

variable "key" {
  type        = string
  description = "The key name to use for the instance."
}

variable "update_version_flag" {
  type        = bool
  description = "Whether to update Default Version each update. Conflicts with \"default_version\""
}

variable "instance_profile_enabled" {
  type        = bool
  description = "Flag to use an role for EC2 Instance profile"
}

variable "instance_profile_role_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the instance profile. The instance_profile_enabled must be true"
}

variable "user_data" {
  type = string
  default = ""
  description = "The Base64-encoded user data to provide when launching the instance."
}

variable "tags" {
  default = null
}