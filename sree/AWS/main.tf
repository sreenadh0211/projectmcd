provider "aws" {
  access_key = "xxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxx"
  region     = "us-east-1"
  }
resource "aws_instance" "mydemo" {
  ami = "ami-0915e09cc7ceee3ab"
  instance_type = "t2.micro"
  key_name = "mcdonals"
  tags = {
   Name = "JENKINS1"
   }
 }

resource "aws_instance" "mydemo1" {
  ami = "ami-0915e09cc7ceee3ab"
  instance_type = "t2.micro"
  key_name = "mcdonals"
  tags = {
   Name = "JENKINS2"
   }
 }
resource "aws_instance" "mydemo2" {
  ami = "ami-0915e09cc7ceee3ab"
  instance_type = "t2.micro"
  key_name = "mcdonals"
  tags = {
   Name = "JENKINS3"
   }
 }

