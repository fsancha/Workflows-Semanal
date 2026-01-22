

module "vpc" {

  source = "git::https://github.com/stemdo-labs/terraform-weekly-exercise-fsancha/tree/main/soluciones/modulo-weekly-exercise/modules/vpc"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
}


module "alb" {
  source = "git::https://github.com/stemdo-labs/terraform-weekly-exercise-fsancha/tree/main/soluciones/modulo-weekly-exercise/modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}


module "ec2" {
  source = "git::https://github.com/stemdo-labs/terraform-weekly-exercise-fsancha/tree/main/soluciones/modulo-weekly-exercise/modules/ec2"
  project_name          = var.project_name
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.alb.alb_security_group_id
  instances             = var.instances
  ami_id                = var.ami_id
}



resource "aws_lb_target_group_attachment" "ec2" {
  for_each = module.ec2.instance_ids

  target_group_arn = module.alb.target_group_arn
  target_id        = each.value
  port             = 80
}
