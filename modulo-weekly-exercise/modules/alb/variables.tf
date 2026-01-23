variable "project_name" {
  description = "Nombre del proyecto para tags"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs de las subnets publicas"
  type        = list(string)
}
