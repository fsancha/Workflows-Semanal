# Para crear un Security Group necesitamos el vpc_id.
# En vez de pedirlo como variable, lo sacamos de la primera subnet publica.
data "aws_subnet" "first" {
  id = var.public_subnet_ids[0]
}

# Security Group para las EC2:
# - Permite HTTP (80) SOLO desde el Security Group del ALB
# - Permite salida a Internet (para updates/instalaciones)
resource "aws_security_group" "ec2" {
  name   = "${var.project_name}-ec2-sg"
  vpc_id = data.aws_subnet.first.vpc_id

  ingress {
    description     = "HTTP desde el ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}

# Creamos 1 instancia EC2 por cada item del mapa "instances"
resource "aws_instance" "this" {
  for_each = var.instances

  ami = var.ami_id
  instance_type = each.value.instance_type

  # Repartimos instancias entre subnets (round-robin)
  subnet_id = var.public_subnet_ids[
    index(keys(var.instances), each.key) % length(var.public_subnet_ids)
  ]

  vpc_security_group_ids = [aws_security_group.ec2.id]

  # Opción 2: el user_data se lee desde un archivo en la raíz del repo
  user_data = file("${path.root}/scripts/web.sh")

  tags = {
    Name = "${var.project_name}-${each.value.name}"
  }
}
