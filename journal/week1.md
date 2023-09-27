# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

PROJECT_ROOT/
|
|- variables.tf            # stores the structure of input variables
|- main.tf                 # everything else
|- providers.tf            # defined required providers and their configuration
|- outputs.tf              # stores our outputs
|- terraform.tfvars        # the data of variables we want to load into our Terraform project
|- README.md               # required for root modules


[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terrafrom and Input Variables
### Terraform Cloud Variables

In terraform we can set two kinds of variables:
- Environment Variables - those that would be set in your bash terminal e.g. AWS
- Terrafrom Variables - those that would be set in tfvars file

We can set Terrafrom Cloud Varialbes to be sensitive so they are not shown visibily in the UI.

### Loading Terraform Input Variables
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)
We can use the `-var` flag to set an input variable or override a variable in the tfvars file e.g. `terraform -var user_uuid="override"`

### var-file flag

- TODO: document this flag

### terraform.tfvars

- TODO: This is the default file to load in terrafrom variables in blunk

### auto.tfvars

- TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables takes precedence


## Dealing with Configuration Drift

### Fix Missing Resources with Terraform Import

[Terraform Import](https://developer.hashicorp.com/terraform/language/import)

### Fix Manual Config

If someone goes and modifies cloud resource manually through clickops.

If we run Terrafrom plan is with attempt to put our infrastructure back into the expected state fixing Configuration Drift

### Fix using Terrafrom Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Modules Structure

It is recommended to place modules in a `modules` directory when locally developing modules but you can name whatever you like

### Passing Input Variables

We can pass input variables to our module.

The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places e.g.: 
- Locally
- Github
- Terrafrom registry

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)


## Consideration when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be rained on the latest documentation or information about Terraform.


## Working with Files in Terraform

### Fileexist Function

This is a built in Terraform function to check the existance of a file.

```tf
condition = fileexist(var.error_html_filepath)
```
[fileexist()](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5 Function

`filemd5` is a variant of md5 that hashes the contents of a given file rather than a literal string.

[filemd5()](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variables

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Reference Path Variables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  # https://developer.hashicorp.com/terraform/language/functions/filemd5
  etag = filemd5(var.index_html_filepath)
}
```