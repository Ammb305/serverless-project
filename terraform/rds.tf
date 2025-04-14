resource "aws_db_subnet_group" "private_db_subnet_group" {
  name       = "private_db_subnet_group"
  subnet_ids = [for s in aws_subnet.private_subnet : s.id]
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier            = "serverless-cluster"
  engine                        = "aurora-mysql"
  engine_mode                   = "provisioned"
  engine_version                = "8.0.mysql_aurora.3.04.1"
  database_name                 = "webapp"
  db_subnet_group_name          = aws_db_subnet_group.private_db_subnet_group.name
  vpc_security_group_ids        = [aws_security_group.db-sg.id]
  master_username               = "admin"
  manage_master_user_password   = true
  storage_encrypted             = true
  master_user_secret_kms_key_id = aws_kms_key.aurora_kms_key.key_id
  skip_final_snapshot           = true
  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_kms_key" "aurora_kms_key" {
  description = "My Aurora KMS key"
}