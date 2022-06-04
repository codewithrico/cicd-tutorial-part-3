resource "aws_ecs_task_definition" "service_task_fargate" {
	network_mode = "awsvpc"
	family = var.service_name
	requires_compatibilities = ["FARGATE"]
	cpu = 256
	memory = 512
	execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  	task_role_arn            = aws_iam_role.ecs_task_role.arn
	container_definitions = jsonencode([{
		name = var.service_name
		image = "${var.account_id}.dkr.ecr.eu-central-1.amazonaws.com/codewithrico-cicd-pipeline:${var.image_tag}"
	  	logConfiguration = {
		  logDriver = "awslogs",
		  options   = {
			awslogs-group         = "/aws/ecs/${var.service_name}"
			awslogs-region        = "eu-central-1"
			awslogs-create-group  = "true"
			awslogs-stream-prefix = var.service_name
		  }
		}
		portMappings = [{
			protocol="tcp"
			containerPort=3000
			hostPort=3000
		}]}
	])
}

resource "aws_ecs_service" "ecs_service" {
  name = "${var.service_name}-service"
  cluster = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.service_task_fargate.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
	subnets = data.aws_subnet_ids.private.ids
	assign_public_ip = false
	security_groups = [aws_security_group.ecs_tasks.id]
  }

#  load_balancer {
#	target_group_arn = aws_alb_target_group.target_group.arn
#	container_name = var.service_name
#	container_port = 3000
#  }
}
