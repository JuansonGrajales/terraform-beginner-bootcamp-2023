terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
   cloud {
    organization = "JuansonGrajales"

    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "dominoes_home" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home"{
  name = "Classic Dominoes Game"
  description = "Tips, Tricks, and Strategies to playing Dominoes"
  domain_name = module.dominoes_home.domain_name
  # domain_name = "test.cloudfront.net"
  town = "missingo"
  content_version = 1
}

module "crepes_home" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "crepes"{
  name = "Crepes"
  description = "Let's make crepes"
  domain_name = module.crepes_home.domain_name
  # domain_name = "test.cloudfront.net"
  town = "missingo"
  content_version = 1
}