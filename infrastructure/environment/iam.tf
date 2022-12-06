module "backend_api_policy" {
    source      = "../modules/resources/iam-policy"
    name        = "${var.environment}-backend-api-policy"
    description = "The general policy for backend api applications"
    policy      = file("policies/backend-api-policy.json")
}

module "service_role_ecs" {
    source = "../modules/resources/iam-service-linked-role"
    aws_service_name = "ecs.amazonaws.com"
}

data "aws_iam_policy_document" "ecs-tasks-assume-role-policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "ec2-assume-role-policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

module "task_role" {
    source                  = "../modules/resources/iam-role"
    role_name               = "${var.environment}-ecs-task-role"
    role_description        = "Allows ECS tasks to call AWS services on your behalf."
    assume_role_policy      = data.aws_iam_policy_document.ecs-tasks-assume-role-policy.json
    managed_policy_arn_list = [
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
        "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess",
        module.backend_api_policy.arn
    ]

    depends_on = [
        module.backend_api_policy.arn
    ]
}

module "ecs_instance_role" {
    source                  = "../modules/resources/iam-role"
    role_name               = "${var.environment}-ecs-instance-role"
    assume_role_policy      = data.aws_iam_policy_document.ec2-assume-role-policy.json
    managed_policy_arn_list = ["arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"]
}

module "ecs_instance_profile" {
    source      = "../modules/resources/iam-instance-profile"
    name        = "${var.environment}-ecs-instance-profile"
    role_name   = module.ecs_instance_role.name

    depends_on = [module.ecs_instance_role]
}