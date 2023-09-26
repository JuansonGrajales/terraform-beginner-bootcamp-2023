resource "random_string" "bucket_name" {
  # https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
  length = 32
  special = false
  upper = false
  lower = true
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
  tags = {
    UserUuid = var.user_uuid
  }
}

