aws_region = "eu-west-3"

project_name = "semanal"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]


instances = {
  web1 = {
    name          = "web1"
    instance_type = "t2.micro"
  }

  web2 = {
    name          = "web2"
    instance_type = "t2.micro"
  }
}

ami_id = "ami-0c73f2f84f9def529"
