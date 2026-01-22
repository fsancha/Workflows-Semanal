output "alb_dns_name" {
  description = "URL publica del Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_url" {
  value = "http://${module.alb.alb_dns_name}"
}

output "ec2_instance_ids" {
  value = module.ec2.instance_ids
}
