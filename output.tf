output "iot_endpoint" {
    value = data.aws_iot_endpoint.thing_ats_mqtt.endpoint_address
}

output "iot_topic" {
    value = var.topic
}

output "thing_cert" {
    value = aws_iot_certificate.thing[*].certificate_pem
    sensitive = true
}

output "thing_pvtkey" {
    value = aws_iot_certificate.thing[*].private_key
    sensitive = true
}

output "thing_cert_pubkey" {
    value = aws_iot_certificate.thing[*].public_key
    sensitive = true
}

output "AmazonRootCA1_response" {
    value = data.http.AmazonRootCA1.response_body
}

output "thing_name" {
    value = aws_iot_thing.thing[*].name
}

output "thing_arn" {
    value = aws_iot_thing.thing[*].arn
}
