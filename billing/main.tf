terraform {
  cloud {
    organization = "024_2023-summer-cloud"

    workspaces {
      name = "infra-billing"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "billing_alert" {
  source = "binbashar/cost-billing-alarm/aws"

  aws_env = "ziyotek"
  monthly_billing_threshold = 30
  currency = "USD"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = module.billing_alert.sns_topic_arns[0]
  protocol  = "email"
  endpoint  = "anilgencdogus@gmail.com"
}
