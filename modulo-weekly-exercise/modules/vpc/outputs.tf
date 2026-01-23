output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs de las subnets publicas"
  value       = [for subnet in aws_subnet.public : subnet.id]
}
