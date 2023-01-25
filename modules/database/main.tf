# --- database/main.tf ---

# resource "aws_db_instance" "three_tier_db" {
#   allocated_storage      = var.db_storage
#   engine                 = "mysql"
#   engine_version         = var.db_engine_version
#   instance_class         = var.db_instance_class
#   db_name                = var.db_name
#   username               = var.dbuser
#   password               = var.dbpassword
#   db_subnet_group_name   = var.db_subnet_group_name
#   identifier             = var.db_identifier
#   skip_final_snapshot    = var.skip_db_snapshot
#   vpc_security_group_ids = [var.rds_sg]

#   tags = {
#     Name = "three-tier-db"
#   }
# }


# resource "aws_rds_cluster" "three_tier_db" {
#   cluster_identifier = "three-tier-db"
#   engine = "mysql"
#   engine_version = data.aws_rds_engine_version.latest_mysql.version
#   storage_type              = "io1"
#   allocated_storage         = 100
#   iops                      = 1000
#   db_cluster_instance_class = "db.r6gd.xlarge"
#   #db_subnet_group_name = module.networking.aws_db_subnet_group
#   #vpc_security_group_ids = [module.networking.rds_sg]
#   availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
#   master_username = var.dbuser
#   master_password = var.dbpassword
#   skip_final_snapshot = true

#   tags = {
#     Name = "three-tier-db"
#   }
# }

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_rds_cluster" "three_tier_db" {
  cluster_identifier = "three-tier-db"
  engine = "mysql"
  engine_version = var.db_engine_version
  storage_type              = "io1"
  allocated_storage         = var.db_storage
  iops                      = 1000
  db_cluster_instance_class = var.db_instance_class
  db_subnet_group_name = var.db_subnet_group_name
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  master_username = var.dbuser
  master_password = var.dbpassword
  skip_final_snapshot = true

  tags = {
    Name = "three-tier-db"
  }
}