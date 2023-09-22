# Terraform Beginner Bootcamp 2023

## Semantic Versioning
This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org)

Given a version number **MAJOR.MINOR.PATCH**, increment the:


- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

General Format:

**MAJOR**.**MINOR**.**PATCH**, e.g. `1.0.1`

## Install the Terraform CLI

The Terraform CLI installation instructions have changed due to the gpg keyring changes. Refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs. 
[How to check OS version in linux](https://linuxize.com/post/how-to-check-linux-version/)

Example of checking OS Version
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. We decided to create a bash script to install the Terraform CLI.

The bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File tidy
- This allow us an easier debug and execute manually Terraform CLI install
- This will allow better portability for other programs needed to install Terraform CLI

#### Shebang

A shebang (pronounced Sha-bang) tells the bash scripts what program that will interpret the script.

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability of different OS distributions
- will search the user's PATH for the bash executables

https://en.wikipedia.org/wiki/Shebang_(Unix)

### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the script.
e.g. `./bin/install_terraform_cli`
If we are using a script in gitpot.yml we need to point the script to a program to interpret it.
e.g. `source ./bin/install_terraform_cli`

### Linux Permission Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be executable at the user mode.

this
```sh
chmod u+x ./bin/install_terraform_cli
```
or that
```sh
chmod 744 ./bin/install_terraform_cli
```
https://en.wikipedia.org/wiki/Chmod

### Gitpod lifecycle (Before, Init, Command)
We need to be careful when using the Init because it will not rerun if we restart an exisiting workspace.

### Working with Env Vars

We can list out all Environment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep e.g. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command
```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export e.g.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo e.g. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. e.g. `.bash_profile`

##### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secret Storage

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals 

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following:
```sh
aws sts get-caller-identity
```

If successful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIEAVUO1......",
    "Account": "1234567890..",
    "Arn": "arn:aws:iam::1234567890:user/user-name"
}
```

We'll need to generate AWS CLI credits from IAM User in order to use the AWS CLI 