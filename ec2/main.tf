terraform {
  cloud {
    organization = "024_2023-summer-cloud"

    workspaces {
      name = "infra-ec2"
    }
  }
}