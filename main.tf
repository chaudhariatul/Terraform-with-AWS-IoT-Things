terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = var.region
}

resource "aws_iot_thing" "thing" {
    count = length(var.thing)
    name = var.thing[count.index]
}

resource "aws_iot_certificate" "thing" {
    count = length(var.thing)
    active = true
}

resource "aws_iot_policy" "thing" {
    name = var.thing_policy
    policy = data.aws_iam_policy_document.aws_iot_thing_policy.json
}

resource "aws_iot_policy_attachment" "cert_policy_attach" {
  count = length(var.thing)
  policy = aws_iot_policy.thing.name
  target = aws_iot_certificate.thing[count.index].arn
}

resource "aws_iot_thing_principal_attachment" "thing_cert_attach" {
  count = length(var.thing)
  principal = aws_iot_certificate.thing[count.index].arn
  thing     = aws_iot_thing.thing[count.index].name
}

