# ecs.tf - ECS resource definitions

resource "aws_ecs_cluster" "wordpress_cluster" {
  name = "wordpress-cluster"
}

resource "aws_ecs_task_definition" "wordpress" {
  family                   = "wordpress"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name             = "wordpress",
      image            = "277387736182.dkr.ecr.eu-west-1.amazonaws.com/bitnami:latest",
      cpu              = 512,
      memory           = 1024,
      essential        = true,
      portMappings     = [
        {
          containerPort = 80,
          hostPort      = 80
        }
      ],
      environment = [
        { name = "WORDPRESS_DATABASE_HOST", value = aws_db_instance.wp_db.address },
        { name = "WORDPRESS_DATABASE_USER", value = "wp_user" },
        { name = "WORDPRESS_DATABASE_PASSWORD", value = var.wordpress_password },
        { name = "WORDPRESS_DATABASE_NAME", value = "wordpress" }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "/ecs/wordpress",
          "awslogs-region"        = "eu-west-1",
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.wordpress_cluster.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.private1.id, aws_subnet.private2.id]
    security_groups = [aws_security_group.sg.id]
    assign_public_ip = true
  }
}
