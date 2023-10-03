terraform {
  cloud {
    organization = "024_2023-summer-cloud"

    workspaces {
      name = "infra-workspaces"
    }
  }
  required_providers {
    tfe = {
      version = "~> 0.49.0"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io" # Optional, defaults to Terraform Cloud `app.terraform.io`
  version  = "~> 0.49.0"
}

data "tfe_organization" "summer-cloud" {
  name = "024_2023-summer-cloud"
}

locals {
  infra-components = [
    "vpc",
    "subnet",
    "ec2",
  ]
  exec_type = "local"
}

resource "tfe_workspace" "test" {
  for_each       = toset(local.infra-components)
  name           = "infra-${each.key}"
  organization   = data.tfe_organization.summer-cloud.name
  execution_mode = local.exec_type
}
