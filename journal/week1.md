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