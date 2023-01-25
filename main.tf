# --- root/main.tf ---

provider "aws" {
  shared_config_files       = ["/home/ec2-user/.aws/config"]
  shared_credentials_files  = ["/home/ec2-user/.aws/credentials"]
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_rds_engine_version" "latest_mysql" {
  engine = "mysql"
}

locals {
  instance_type = "t2.micro"
  db_instance_class = "db.r6gd.xlarge"
  db_storage    = 100
  vpc_cidr      = "10.123.0.0/16"
  region        = data.aws_region.current.name
  availabilityzone = data.aws_availability_zones.available.names[0]
  key_name = "test_delete"
}

module "networking" {
  source            = "/home/ec2-user/environment/Terraform_AWS_Three_Tier_Architecture/modules/networking"
  vpc_cidr          = local.vpc_cidr
  access_ip         = var.access_ip
  public_sn_count   = 2
  private_sn_count  = 3
  db_subnet_group   = true
  availabilityzone  = "${local.availabilityzone}"
  azs               = 3
}

module "compute" {
  source                  = "/home/ec2-user/environment/Terraform_AWS_Three_Tier_Architecture/modules/compute"
  frontend_app_sg         = module.networking.frontend_app_sg
  backend_app_sg          = module.networking.backend_app_sg
  bastion_sg              = module.networking.bastion_sg
  public_subnets          = module.networking.public_subnets
  private_subnets         = module.networking.private_subnets
  bastion_instance_count  = 1
  instance_type           = local.instance_type
  key_name                = "${local.key_name}"
  lb_tg_name              = module.loadbalancing.lb_tg_name
  lb_tg                   = module.loadbalancing.lb_tg

}

module "database" {
  source               = "/home/ec2-user/environment/Terraform_AWS_Three_Tier_Architecture/modules/database"
  db_storage           = local.db_storage
  db_engine_version    = data.aws_rds_engine_version.latest_mysql.version
  db_instance_class    = local.db_instance_class
  db_name              = var.db_name
  dbuser               = var.dbuser
  dbpassword           = var.dbpassword
  db_identifier        = "three-tier-db"
  skip_db_snapshot     = true
  rds_sg               = module.networking.rds_sg
  db_subnet_group_name = module.networking.db_subnet_group_name[0]
}



module "loadbalancing" {
  source                  = "/home/ec2-user/environment/Terraform_AWS_Three_Tier_Architecture/modules/loadbalancing"
  lb_sg                   = module.networking.lb_sg
  public_subnets          = module.networking.public_subnets
  tg_port                 = 80
  tg_protocol             = "HTTP"
  vpc_id                  = module.networking.vpc_id
  app_asg                 = module.compute.app_asg
  listener_port           = 80
  listener_protocol       = "HTTP"
  azs                     = 2
}
