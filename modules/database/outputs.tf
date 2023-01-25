# --- database/outputs.tf ---

#output "db_endpoint" {
#  value = aws_db_instance.three_tier_db.endpoint
#}

output "db_endpoint" {
  value = aws_rds_cluster.three_tier_db.endpoint
}
 
output "db_reader_endpoint" {
  value = aws_rds_cluster.three_tier_db.reader_endpoint
}
