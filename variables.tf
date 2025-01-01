variable "listener_arn" {}

variable "priority" {}

variable "type" {
  default  = "forward"
  nullable = false
}

variable "target_group_arn" {
  default = null
}

variable "redirects" {
  type = map(object({
    host        = optional(string)
    path        = optional(string)
    port        = optional(string)
    protocol    = optional(string)
    query       = optional(string)
    status_code = optional(string, "HTTP_301")
  }))
  default  = {}
  nullable = false
}

variable "conditions" {
  type = map(object({
    host_header         = optional(set(string))
    path_pattern        = optional(set(string))
    http_request_method = optional(set(string))
    source_ip           = optional(set(string))
    http_header         = optional(map(string), {})
    query_string        = optional(map(string), {})
  }))
  default  = {}
  nullable = false
}