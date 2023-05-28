terraform {
  backend "s3" {
    key     = "terraform.state"
    encrypt = true
    region  = "us-east-1"
  }
}
