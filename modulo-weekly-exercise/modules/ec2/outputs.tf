output "instance_ids" {
  description = "IDs de las instancias EC2 creadas"
  value       = { for k, v in aws_instance.this : k => v.id }
}
