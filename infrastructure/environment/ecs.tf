data "template_file" "configure_ecs_cluster_instance_script"{
  template = file("scripts/configure-ecs-cluster-instance.sh")
  vars = {
    cluster_name = local.cluster_name
  }
}

module "backend_apis_ecs_launch_template"{
  source                    = "../modules/resources/ec2-launch-template"
  name                      = "${local.cluster_name}-lt"
  description               = "Cluster for Backends APIs"
  ami                       = var.ecs_instances_ami
  instance_type             = "t3.medium"
  sg_ids                    = [module.backends_apps_ec2_sg.security_group_id]
  key                       = var.key_pair
  update_version_flag       = true
  instance_profile_enabled  = true
  instance_profile_role_arn = module.ecs_instance_profile.arn
  user_data                 = base64encode(data.template_file.configure_ecs_cluster_instance_script.rendered)

  tags = {
    Environment: var.environment,
    Cluster: local.cluster_name
  }

  depends_on = [
    module.backends_apps_ec2_sg,
    module.ecs_instance_profile,
  ]
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = var.vpc_id
}

module "backend_apis_ecs_spot_autoscaling" {
  source                        = "../modules/resources/ec2-autoscaling-group"
  name                          = "${local.cluster_name}-spot-asg"
  desired_count                 = 1
  min_size                      = 1
  max_size                      = 1
  is_capacity_rebalanced        = true
  subnet_ids                    = data.aws_subnet_ids.subnet_ids.ids
  health_check_type             = "EC2"
  health_check_period           = 30
  launch_template_id            = module.backend_apis_ecs_launch_template.id

  on_demand_allocation_strategy = "prioritized"
  on_demand_capacity            = 0
  on_demand_above_base_capacity = 0
  spot_allocation_strategy      = "capacity-optimized-prioritized"
  instances_type                = tolist(["t3a.medium", "t3.medium", "t2.medium"])

  tags = concat(
  [
    {
      key   = "Environment",
      value = var.environment,
      propagate_at_launch = "true"
    },
    {
      key   = "Cluster",
      value = local.cluster_name,
      propagate_at_launch = "true"
    },
    {
      key   = "InstancePricing",
      value = "Spot"
      propagate_at_launch = "true"
    },
    {
      key = "AmazonECSManaged"
      value = ""
      propagate_at_launch = true
    },
    {
      key = "Name"
      value = "${local.cluster_name}-spot-instance"
      propagate_at_launch = true
    },
  ])

  depends_on = [
    module.backend_apis_ecs_launch_template,
    data.aws_subnet_ids.subnet_ids,
  ]
}

module "backend_apis_ecs_spot_capacity_provider" {
  source                          = "../modules/resources/ecs-capacity-provider"
  name                            = "${local.cluster_name}-spot-capacity-provider"
  auto_scaling_group_arn          = module.backend_apis_ecs_spot_autoscaling.arn

  depends_on = [
    module.backend_apis_ecs_spot_autoscaling,
    module.service_role_ecs,
  ]
}

module "backend_apis_ecs_cluster" {
  source                      = "../modules/resources/ecs-cluster"
  cluster_name                = "${local.cluster_name}"

  default_capacity_providers  = tolist([module.backend_apis_ecs_spot_capacity_provider.name])

  capacity_providers          = [
    module.backend_apis_ecs_spot_capacity_provider.name,
  ]

  tags                        = {
    Environment: var.environment,
    Cluster: local.cluster_name
  }

  propagate_tags              = {
    Environment: var.environment,
    Cluster: local.cluster_name,
  }

  depends_on = [
    module.backend_apis_ecs_spot_capacity_provider,
  ]
}