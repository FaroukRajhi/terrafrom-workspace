provider "aws" {
  region = var.region

}
resource "aws_instance" "instance-one" {
  ami = var.ami
  instance_type = var.size
  tag = {
    Name = "server-${terraform-workspace}"
  }
}

// We can use different size of instance for different environment also, for that we need to modify our file as below

// After creating a workspace using "terraform workspace new staging" then initplan apply
// terrafom workspace new dev
// terraform workspace new prod
provider "aws" {
  region = var.region
}

locals {
  instance_types = {
    dev   = "t2.micro"
    stg = "t2.small"
    prod  = "m4.large"
  }
}

resource "aws_instance" "demo_server" {
  ami           = var.ami
  instance_type = local.instance_types[terraform.workspace]
  tags = {
    Name = "example-server-${terraform.workspace}"
  }
}

/*
We can also store state file for all the workspaces in S3 also, and for that create backend.tf file and add below code in it
*/
terraform {
backend "s3" {
  bucket = "dhsoni-tf"
  region = "us-east-2"
  key    = "terraform.tfstate"
}
}