variable "name" {
  type        = string
  description = "(Optional) The name of the Auto Scaling Group. By default generated by Terraform. Conflicts with name_prefix"
}

variable "desired_count" {
  type        = number
  description = "The number of Amazon EC2 instances that should be running in the group."
}

variable "min_size" {
  type        = number
  description = "The minimum size of the Auto Scaling Group"
}

variable "max_size" {
  type        = number
  description = "The maximum size of the Auto Scaling Group"
}

variable "is_capacity_rebalanced" {
  type        = bool
  default     = false
  description = "(Optional) Indicates whether capacity rebalance is enabled. Otherwise, capacity rebalance is disabled."
}

variable "subnet_ids" {
  type        = list
  default     = []
  description = "(Optional) A list of one or more availability zones for the group. Used for EC2-Classic, attaching a network interface via id from a launch template and default subnets when not specified with vpc_zone_identifier argument. Conflicts with vpc_zone_identifier."
}
variable "health_check_type" {
  type        = string
  default     = "EC2"
  description = "(Optional) \"EC2\" or \"ELB\". Controls how health checking is done."
}

variable "health_check_period" {
  type        = string
  description = "Time after instance comes into service before checking health."
}

variable "target_group_arns" {
  type        = list
  default     = []
  description = "(Optional) A set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing."
}

variable "on_demand_allocation_strategy" {
  type        = string
  default     = "prioritized"
  description = "(Optional) Strategy to use when launching on-demand instances. Valid values: prioritized. Default: prioritized"
}

variable "on_demand_capacity" {
  type        = number
  default     = 0
  description = "(Optional) Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances. Default: 0."
}

variable "on_demand_above_base_capacity" {
  type        = number
  default     = 100
  description = "(Optional) Percentage split between on-demand and Spot instances above the base on-demand capacity. Default: 100."
}

variable "spot_allocation_strategy" {
  type        = string
  default     = "lowest-price"
  description = "(Optional) How to allocate capacity across the Spot pools. Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized. Default: lowest-price."
}

variable "spot_max_price" {
  type        = string
  default     = ""
  description = "(Optional) Maximum price per unit hour that the user is willing to pay for the Spot instances. Default: an empty string which means the on-demand price."
}

variable "launch_template_id" {
  type        = string
  description = "(Optional) The ID of the launch template. Conflicts with launch_template_name."
}

variable "instances_type" {
  description = "(Optional) Override the instance type in the Launch Template. (LIST)"
}

variable "tags" {
  default = null
}