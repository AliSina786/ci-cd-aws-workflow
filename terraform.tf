terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "$YourOrganizationName"

    workspaces {
      name = "YourWorkspaceName"
    }
  }
}