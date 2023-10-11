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

module "dominoes_home_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.dominoes.public_path
  content_version = var.dominoes.content_version
}

resource "terratowns_home" "home"{
  name = "Classic Dominoes Game"
  description = "Tips, Tricks, and Strategies to playing Dominoes"
  domain_name = module.dominoes_home_hosting.domain_name
  town = "missingo"
  content_version = var.dominoes.content_version
}

module "crepes_home_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.crepes.public_path
  content_version = var.crepes.content_version
}

resource "terratowns_home" "crepes"{
  name = "Crepes"
  description = "Let's make crepes"
  domain_name = module.crepes_home_hosting.domain_name
  town = "missingo"
  content_version = var.crepes.content_version
}