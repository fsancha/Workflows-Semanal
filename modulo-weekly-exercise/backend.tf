terraform {
  backend "s3" {
    bucket         = "tfstate-fsancha-eu-west-3"
    key            = "workflows-semanal/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "tfstate-lock-fsancha"
    encrypt        = true
  }
}
