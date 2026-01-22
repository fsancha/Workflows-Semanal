# Workflows de GitHub Actions 


En esta carpeta se incluyen los ficheros YAML de los workflows solicitados para:
- Ejecutar `terraform plan` en Pull Requests
- Ejecutar `terraform apply` en merges/push a `main`
- Ejecutar manualmente `plan`, `apply` o `destroy`



## Requisitos
- Runner: `self-hosted` con etiqueta `stemdo-labs`
- Región AWS: `eu-west-3`
- Secrets en GitHub (no en texto plano):
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - (opcional) `AWS_SESSION_TOKEN`

## Notas
- Los comandos usan `terraform.tfvars` para cargar variables del proyecto.
- El workflow manual incluye `terraform destroy` para cumplir la limpieza final del ejercicio....
