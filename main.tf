provider "aws" {
  region = var.region

}
resource "aws_instance" "instance-one" {
  ami = var.ami
  instance_type = var.size
  tag = {
    Name = "demo-server"
  }
}