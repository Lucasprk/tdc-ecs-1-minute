variable "alb_name" {
  type = string
}
variable "security_group_ids" {}
variable "subnet_ids" {}
variable "http_port" {
  type    = number
  default = 80
}
variable "https_port" {
  type = number
  default = 443
}
variable "is_internal" {
  default = true
}
variable "enable_deletion_protection" {
  default = false
}

