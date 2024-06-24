data "aws_iot_endpoint" "thing_ats_mqtt" {
    endpoint_type = "iot:Data-ATS"
}

data "http" "AmazonRootCA1" {
    url = "https://www.amazontrust.com/repository/AmazonRootCA1.pem"
    method = "GET"
}


data "aws_iam_policy_document" "aws_iot_thing_policy" {
    version = "2012-10-17"
    statement {
        sid = "ClientConnectRestrictred"
        effect = "Allow"
        actions = [
            "iot:Connect"
        ]
        resources = [
            "arn:aws:iot:${var.region}:${var.account}:client/$${iot:Connection.Thing.ThingName}"
        ]
    }
    statement {
        sid = "PublishReceivePermissions"
        effect = "Allow"
        actions = [
            "iot:Publish",
            "iot:Receive"
        ]
        resources = [
            "arn:aws:iot:${var.region}:${var.account}:topic/${var.topic}/$${iot:Connection.Thing.ThingName}"
        ]
    }
    statement {
        sid = "SubscribePermissions"
        effect = "Allow"
        actions = [
            "iot:Subscribe"
        ]
        resources = [
            "arn:aws:iot:${var.region}:${var.account}:topicfilter/${var.topic}/$${iot:Connection.Thing.ThingName}"
        ]
    }
}
