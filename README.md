# GitHub Repository Terraform Module

This Terraform module creates a private repository on GitHub, and adds a deploy key to it. Also it creates yaml Flux configuration files to deploy kbot-app into the GKE cluster.

## Usage

```hcl
module "github_repository" {
  source                   = "https://github.com/SVestor/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux"
  commit_message           = var.commit_message
  commit_author            = var.commit_author
  commit_email             = var.commit_email  
}
module "tls_private_key" {
  source = "https://github.com/SVestor/tf-hashicorp-tls-keys"
  algorithm   = var.algorithm
}
```
## Inputs
- github_owner - The name of the GitHub account that will own the repository.
- github_token - A GitHub personal access token with the repo scope.
- repository_name - (Optional) The name of the repository to create. Default is test-provider.
- repository_visibility - (Optional) The visibility of the repository. Default is private.
- branch - (Optional) The name of the branch to create. Default is main.
- public_key_openssh - The public key to use as a deploy key for the repository.
- public_key_openssh_title - The title of the public key to use as a deploy key for the repository.
- commit_message - (Optional) - The commit message to create. Default is "Managed by Terraform"
- commit_author - (Optional)  - Default is "Terraform User"
- commit_email  - (Optional)  - Default is "terraform@gh.com"

## Outputs
- repository_name - The name of the created repository.

## Requirements
This module requires Terraform 0.12 or later, and the following provider:

github version >= 5.9.1

## License
This module is licensed under the MIT License. See the LICENSE file for details.
