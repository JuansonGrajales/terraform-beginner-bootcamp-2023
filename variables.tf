variable "teacherseat_user_uuid"{
    type = string
}

variable "bucket_name" {
    type = string
}

variable "dominoes" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "crepes" {
  type = object({
    public_path = string
    content_version = number 
  })
}

variable "terratowns_endpoint" {
  type = string
}

variable "terratowns_access_token" {
  type = string
}