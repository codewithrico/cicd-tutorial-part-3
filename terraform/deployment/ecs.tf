resource "aws_ecs_cluster" "cluster" {
  name = "${var.service_name}-ecs"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.current.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.current.name
      }
    }
  }
}

resource "aws_kms_key" "current" {
  description             = "${var.service_name}-ecs kms key"
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "current" {
  name = "${var.service_name}-ecs"
}
