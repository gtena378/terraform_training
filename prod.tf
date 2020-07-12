provider "aws" {
  profile    = "default"
  region     = "us-west-2"
  access_key = "AKIASYIXHAJYZ3XX4BVU"
  secret_key = "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"

  #   shared_credentials_file = "/home/osboxes/.aws/credentials"
}

resource "aws_s3_bucket" "prod_tf_course" {
  bucket = "tena-tf-course-20200709"
  acl    = "private"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "prod_web" {
  name        = "prod_web"
  description = "Allow standard http and https ports nbound and everything outbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_instance" "prod_web" {
  ami           = "ami-01ebd27ddd89835f4"
  instance_type = "t2.nano"

  vpc_security_group_ids = [
    aws_security_group.prod_web.id
  ]

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_eip" "prod_web" {
  instance = aws_instance.prod_web.id

  tags = {
    "Terraform" : "true"
  }
}
