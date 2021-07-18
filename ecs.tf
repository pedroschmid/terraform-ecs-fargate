# ECS #

# ECS cluster
resource "aws_ecs_cluster" "this" {
  name = "ecs-cluster-${var.ENVIRONMENT}"
}

# Template file for rails
data "template_file" "rails" {
  template = file("templates/rails.json.tpl")

  vars = {
    IMAGE       = aws_ecr_repository.rails.repository_url
    REGION      = var.REGION
    ENVIRONMENT = var.ENVIRONMENT
  }
}

# ECS task definition
resource "aws_ecs_task_definition" "rails" {
  family = "rails"
  container_definitions = data.template_file.rails.rendered
}

# ECS service
resource "aws_ecs_service" "this" {
  name = "rails-ecs-service-${var.ENVIRONMENT}"
  cluster = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.rails.arn
  iam_role = aws_iam_role.ecs_service_role.arn
  desired_count = 1

  depends_on = [
    aws_alb_listener.this,
    aws_iam_role_policy.ecs_service_role_policy
  ]

  load_balancer {
    target_group_arn = aws_alb_target_group.default.arn
    container_name = "rails"
    container_port = 3000
  }
}