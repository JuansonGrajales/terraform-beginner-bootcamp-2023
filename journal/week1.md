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
module "terrahome_aws" {
  source = "./modules/terrahome_aws"
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

### Terraform Locals

Locals allow us to define local variables.
It can be very useful when we need transform data into another format and have a referenced variable.
```tf
locals {
  s3_origin_id = "Mys3Origin"
}
```
[Locals Vars](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

This allows use to source data from cloud

This is useful when we want to reference cloud resource without importing them

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Source](https://developer.hashicorp.com/terraform/language/data-sources)

## Working JSON

`jsonencode` encodes a given value to a string using JSON syntax.

```
jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode()](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Chaning the Lifecycle of Resources

[Meta Argument Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### Terraform Data

The `terraform_data` implements the standard resource lifecycle, but does not directly take any other actions. You can use the `terraform_data` resource without requiring or configuring a provider. It is always available through a built-in provider with the source address terraform.io/builtin/terraform.
[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners

Provisioners allow you to execute commands on comute instances e.g. AWS CLI command.
They are not best practice because configurations tools such as Ansible are a better fit.
But this practice does exist and should be known.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute a command on the machine running the Terraform commands
```tf
provisioner "aws_instance" "web" {
  command = "echo The server's IP address is ${self.private_ip}
}
```

### Remote-exec

This will execute a commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

## For_each expressions 
`for_each` is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.

The `for_each` meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

Mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.

[for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)