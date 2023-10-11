output "bucket_name" {
    description = "s3 bucket name for our static website"
    value = module.dominoes_home_hosting.bucket_name
}

output "s3_website_endpoint" {
  value = module.dominoes_home_hosting.website_endpoint
  description = "S3 static website hosting endpoint"
}

output "domain_name" {
  description = "The Cloudfron Distribution name"
  value = module.dominoes_home_hosting.domain_name
}