provider "aws" {
  profile    = "default"
  region     = "us-west-2"
  access_key = "AKIASYIXHAJYZ3XX4BVU"
  secret_key = "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"

  #   shared_credentials_file = "/home/osboxes/.aws/credentials"
}

resource "aws_s3_bucket" "tf-course" {
  bucket = "tena-tf-course-20200709"
  acl    = "private"
}
