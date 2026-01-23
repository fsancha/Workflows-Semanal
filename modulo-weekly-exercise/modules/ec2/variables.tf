variable "project_name" {
  description = "Nombre del proyecto para tags"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs de las subnets publicas"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security Group del ALB"
  type        = string
}

variable "instances" {
  description = "Mapa de instancias EC2"
  type = map(object({
    name          = string
    instance_type = string
  }))
}

variable "ami_id" {
  description = "AMI de las instancias EC2"
  type        = string
}

