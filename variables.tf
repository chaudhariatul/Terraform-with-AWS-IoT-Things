variable "region" {
    description = "AWS Region to create the thing."
}

variable "account" {
    description = "AWS account"
}

variable "thing_policy" {
    description = "Name of the Policy to apply to certificate." 
}

variable "topic" {
    description = "Name of the topic in the path for MQTT."
}

variable "thing" {
    description = "Name of the IoT Thing"
    type        = list(string)
}