# ======================
# Variables globales
# ======================

variable "aws_region" {
  description = "Region de AWS"
  type        = string
}

variable "project_name" {
  description = "Prefijo para nombres y tags del proyecto"
  type        = string
}

# ======================
# Variables de VPC
# ======================

variable "vpc_cidr" {
  description = "CIDR de la VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR de las subnets publicas"
  type        = list(string)
}


# ======================
# Variables de EC2
# ======================

variable "instances" {
  description = "Mapa de instancias EC2"
  type = map(object({
    name          = string
    instance_type = string
  }))
}

variable "ami_id" {
  description = "AMI para EC2 (debe existir en eu-west-3)"
  type        = string
}


