variable tg_name {
  type = string
  description = "(Forces new resource) Name of the target group, must be unique."
}

variable tg_protocol {
  type = string
  description = "(May be required, Forces new resource) Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP_UDP, TLS, or UDP. Required when target_type is instance or ip. Does not apply when target_type is lambda."
}

variable application_port {
  type = number
  description = "(May be required, Forces new resource) Port on which targets receive traffic, unless overridden when registering a specific target. Required when target_type is instance or ip. Does not apply when target_type is lambda."
}

variable vpc_ids {
  type = string
  description = "(Optional, Forces new resource) Identifier of the VPC in which to create the target group. Required when target_type is instance or ip. Does not apply when target_type is lambda."
}

variable health_check_path {
  default = "/"
  description = "(May be required) Destination for the health check request. Required for HTTP/HTTPS ALB and HTTP NLB. Only applies to HTTP/HTTPS."
}

variable health_check_port {
  default = "traffic-port"
  description = "(Optional) Port to use to connect with the target. Valid values are either ports 1-65535, or traffic-port. Defaults to traffic-port."
}


variable "healthy_threshold" {
  type = number
  default = 5
  description = "(Optional) Number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 3."
}

variable "unhealthy_threshold" {
  type = number
  default = 3
  description = "(Optional) Number of consecutive health check failures required before considering the target unhealthy. For Network Load Balancers, this value must be the same as the healthy_threshold. Defaults to 3."
}

variable "timeout" {
  type = number
  default = 5
  description = " (Optional) Amount of time, in seconds, during which no response means a failed health check. For Application Load Balancers, the range is 2 to 120 seconds, and the default is 5 seconds for the instance target type and 30 seconds for the lambda target type. For Network Load Balancers, you cannot set a custom value, and the default is 10 seconds for TCP and HTTPS health checks and 6 seconds for HTTP health checks."
}

variable "interval" {
  type = number
  default = 10
  description = " (Optional) Approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. For lambda target groups, it needs to be greater as the timeout of the underlying lambda. Default 30 seconds."
}

variable "matcher" {
  type = number
  default = 200
  description = "(May be required) Response codes to use when checking for a healthy responses from a target. You can specify multiple values (for example, \"200,202\" for HTTP(s) or \"0,12\" for GRPC) or a range of values (for example, \"200-299\" or \"0-99\"). Required for HTTP/HTTPS/GRPC ALB. Only applies to Application Load Balancers (i.e., HTTP/HTTPS/GRPC) not Network Load Balancers (i.e., TCP)."
}