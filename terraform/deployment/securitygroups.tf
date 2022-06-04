resource "aws_security_group" "ecs_tasks" {
  name = "${var.service_name}-sg-ecs-tasks"
  vpc_id = data.aws_vpc.main.id
  ingress {
	  protocol="tcp"
	  from_port=3000
	  to_port=3000
	  cidr_blocks=["0.0.0.0/0"]
  }
  egress {
	  protocol="-1"
	  from_port=0
	  to_port=0
	  cidr_blocks=["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb" {
  name = "${var.service_name}-sg-alb"
  vpc_id = data.aws_vpc.main.id
  ingress {
	  protocol="tcp"
	  from_port=443
	  to_port=443
	  cidr_blocks=["0.0.0.0/0"]
  }
  ingress {
	  protocol="tcp"
	  from_port=80
	  to_port=80
	  cidr_blocks=["0.0.0.0/0"]
  }
  egress {
	  protocol="-1"
	  from_port=0
	  to_port=0
	  cidr_blocks=["0.0.0.0/0"]
  }
}
