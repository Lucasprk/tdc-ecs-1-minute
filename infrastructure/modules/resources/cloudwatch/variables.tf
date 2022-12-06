variable "log_group_name" {
  type = string
  description = "(Forces new resource) The name of the log group, must be unique."
}

variable "log_retention_in_days" {
  type = number
  description = " (Optional) Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
}

variable "application" {
  type = string
  description = "Application Name (Tag)"
}

variable "environment" {
  type = string
  description = "Environment Name (Tag)"
}