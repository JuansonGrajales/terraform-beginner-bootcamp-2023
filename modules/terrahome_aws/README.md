## Terrahome AWS

```tf
module "dominoes_home" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  public_path = var.dominoes_public_path
  content_version = var.content_version
}
```

The public directory expects the following:
- index.html
- error.html
- assets

All top level files in assets will be copied, but not any subdicrectories.