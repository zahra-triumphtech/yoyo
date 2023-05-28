provider "aws" {
    profile= "zubin"
  region  = var.region
  default_tags {
    tags = {
      createdby = "terraform"
    }
  }
}