account = "851759692963"
region = "us-east-1"
environment = "qa"
vpc_id = "vpc-d2c466af"
alb_name = "qa-general-apps-alb"
cluster_name = "qa-backend-apis"

application = {
  name: "customer-api"
  port: 8080
  context: "/customer-api-qa"
  health_check_path: "/customer-api-qa/actuator/health"
  log_retention_days: 14
  environment_variables: [
    {
      name  = "SPRING_PROFILES_ACTIVE"
      value = "qa"
    }
  ]
  execution_role_name: "qa-ecs-task-role"
  task_role_name: "qa-ecs-task-role"
  ecr: "qa/customer-api" // Must be exists in ECR
  providers: [
    {
      capacity_provider = "qa-backend-apis-spot-capacity-provider"
      weight = 50
    }
  ]
}