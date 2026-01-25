# Ejercicio Terraform con GitHub Actions

## 1. Descripción general

En este ejercicio se ha desarrollado una **infraestructura en AWS usando Terraform**, junto con su **automatización mediante GitHub Actions**.

La solución incluye:
- Infraestructura modular (VPC, ALB y EC2).
- Backend remoto en S3 con bloqueo en DynamoDB.
- Módulos reutilizables consumidos desde un **repositorio público propio**.
- Flujos CI/CD con plan en Pull Request y apply en main.
- Workflow manual para plan/apply/destroy.

La región utilizada es **eu-west-3 (París)**.

---

## 2. Infraestructura con Terraform

La infraestructura está dividida en tres módulos reutilizables:

### 2.1 Módulo VPC
Se encarga de crear la red base del sistema:
- VPC
- Internet Gateway
- Subnets públicas
- Tabla de rutas pública

### 2.2 Módulo ALB
Crea un **Application Load Balancer público** que distribuye tráfico HTTP:
- Security Group del ALB
- Load Balancer
- Target Group
- Listener HTTP (puerto 80)

### 2.3 Módulo EC2
Despliega varias instancias EC2 con **Amazon Linux 2 y Apache**, integradas en el ALB.
Cada instancia muestra su `Instance ID` y `Hostname` para comprobar el balanceo.

Las instancias solo aceptan tráfico HTTP desde el ALB.

---

## 3. Uso de módulos desde repositorio público

Los módulos de Terraform (VPC, ALB y EC2) **no están definidos localmente en el repositorio de ejecución**, sino que se consumen desde un **repositorio público creado por mi** con URL: https://github.com/fsancha/Workflows-Semanal.git.

Esto se realiza mediante el atributo `source` en el `main.tf`, utilizando URLs Git:

```hcl
module "vpc" {
  source = "git::https://github.com/fsancha/Workflows-Semanal.git//modulo-weekly-exercise/modules/vpc?ref=main"
}

module "alb" {
  source = "git::https://github.com/fsancha/Workflows-Semanal.git//modulo-weekly-exercise/modules/alb?ref=main"
}

module "ec2" {
  source = "git::https://github.com/fsancha/Workflows-Semanal.git//modulo-weekly-exercise/modules/ec2?ref=main"
}
```


- Los módulos son **reutilizables** y desacoplados del entorno de despliegue.
- No es necesario duplicar código.
- Terraform descarga automáticamente los módulos durante `terraform init`.

---

## 4. Outputs principales

El módulo principal expone los siguientes outputs:

- `alb_dns_name`: DNS público del ALB  
- `alb_url`: URL completa del ALB  
- `ec2_instance_ids`: IDs de las instancias EC2  

Estos outputs permiten verificar fácilmente el despliegue.

---

## 5. Automatización con GitHub Actions

Se han definido tres workflows:

### 5.1 Plan en Pull Request
- Se ejecuta en cada PR contra `main`.
- Realiza `terraform fmt`, `init`, `validate` y `plan`.
- Permite detectar errores antes del merge.

### 5.2 Apply en main
- Se ejecuta al hacer push/merge en la rama `main`.
- Aplica automáticamente la infraestructura.
- Muestra la URL del ALB al finalizar.

### 5.3 Workflow manual
- Permite ejecutar manualmente `plan`, `apply` o `destroy`.
- Útil para pruebas y limpieza de recursos.

---

## 6. Secrets y seguridad

Las credenciales de AWS se gestionan mediante **GitHub Secrets**:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

No se incluyen secretos en el código.

Además:
- `.terraform/` y `*.tfstate` están ignorados con `.gitignore`.
- El estado se guarda en un backend remoto S3.

---

## 7. Validación y pruebas

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Comprobaciones realizadas:
- El ALB responde en su DNS público.
- Las instancias aparecen como *Healthy*.
- El balanceo funciona al refrescar la página.

![alt text](../datos/1.png)


![alt text](../datos/2.png)


Al finalizar las pruebas:
```bash
terraform destroy
```

---


