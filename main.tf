resource "aws_lb_listener_rule" "this" {
  priority     = var.priority
  listener_arn = var.listener_arn

  action {
    type             = var.type
    target_group_arn = var.target_group_arn

    dynamic "redirect" {
      for_each = var.redirects
      content {
        host        = redirect.value.host
        path        = redirect.value.path
        port        = redirect.value.port
        protocol    = redirect.value.protocol
        query       = redirect.value.query
        status_code = redirect.value.status_code
      }
    }
  }

  dynamic "condition" {
    for_each = var.conditions
    content {

      dynamic "host_header" {
        for_each = condition.value.host_header == null ? [] : [0]
        content {
          values = condition.value.host_header
        }
      }

      dynamic "path_pattern" {
        for_each = condition.value.path_pattern == null ? [] : [0]
        content {
          values = condition.value.path_pattern
        }
      }

      dynamic "http_request_method" {
        for_each = condition.value.http_request_method == null ? [] : [0]
        content {
          values = condition.value.http_request_method
        }
      }

      dynamic "source_ip" {
        for_each = condition.value.source_ip == null ? [0] : []
        content {
          values = condition.value.source_ip
        }
      }

      dynamic "http_header" {
        for_each = condition.value.http_header
        content {
          http_header_name = http_header.key
          values           = http_header.value
        }
      }

      dynamic "query_string" {
        for_each = condition.value.query_string
        content {
          key   = query_string.key
          value = query_string.value
        }
      }

    }
  }
}
