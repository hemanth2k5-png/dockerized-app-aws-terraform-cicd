terraform {
  backend "s3" {
    bucket       = "dockerized-app-tfstate-1nb0wskf"
    key          = "dockerized-app/terraform.tfstate"
    region       = "ap-south-2"
    encrypt      = true
    use_lockfile = true
  }
}
