[
  {
    "name": "rails",
    "image": "${ECR_REPOSITORY}",
    "essential": true,
    "cpu": 256,
    "memory": 512,
    "links": [],
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "RAILS_ENV",
        "value": "{ENVIRONMENT}"
      },
      {
        "name": "DATABASE_NAME",
        "value": "${DATABASE_NAME}"
      },
      {
        "name": "DATABASE_USERNAME",
        "value": "${DATABASE_USERNAME}"
      },
      {
        "name": "DATABASE_PASSWORD",
        "value": "${DATABASE_PASSWORD}"
      },
      {
        "name": "DATABASE_HOST",
        "value": "${DATABASE_HOST}"
      },
      {
        "name": "DATABASE_PORT",
        "value": "5432"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${AWS_REGION}",
        "awslogs-group": "rails-log-group-${ENVIRONMENT}",
        "awslogs-stream-prefix": "rails-log-stream-${ENVIRONMENT}"
      }
    }
  }
]