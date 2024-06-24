# Using Terraform to create IoT Things

![design](./images/IoTThingsTerraform.png)

> **Setting up environment with isengard**  
>   
> eval $(isengardcli credentials --role ROLENAME ISENGARD_ACCOUNT_NAME)  
> export $AWS_DEFAULT_REGION=REGION_NAME  

**Step 1.** Clone the git repository  
`git clone https://github.com/chaudhariatul/Terraform-with-AWS-IoT-Things.git && cd Terraform-with-AWS-IoT-Things/`


```
Cloning into 'Terraform-with-AWS-IoT-Things'...
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (13/13), done.
remote: Total 13 (delta 1), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (13/13), 14.29 KiB | 236.00 KiB/s, done.
Resolving deltas: 100% (1/1), done.
```

**Step 2.** Create a new tfvars file  
Use the example.tfvars as a sample file to create a new tfvars variable file.

```
cat << EOF > Cloudgate_Things.tfvars
region = "us-west-1"
account = "123456789012"
thing = ["CG_Thing01", "CG_Thing02", "CG_Thing03"]
thing_policy = "CloudgateCertPolicy"
topic = "cloudgate"
EOF
```

**Step 3.** Terraform init

`terraform init`

  <details>
  <summary><b>Init</b></summary>  

```
    Initializing the backend...

    Initializing provider plugins...
    - Finding latest version of hashicorp/aws...
    - Finding latest version of hashicorp/http...
    - Installing hashicorp/aws v4.30.0...
    - Installed hashicorp/aws v4.30.0 (signed by HashiCorp)
    - Installing hashicorp/http v3.1.0...
    - Installed hashicorp/http v3.1.0 (signed by HashiCorp)

    Terraform has created a lock file .terraform.lock.hcl to record the provider
    selections it made above. Include this file in your version control repository
    so that Terraform can guarantee to make the same selections by default when
    you run "terraform init" in the future.

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
```
</details><br>

**Step 4.** Terraform apply  
`terraform apply -var-file="Cloudgate_Things.tfvars" --auto-approve`

  <details>
  <summary><b>Output</b></summary>  

```
data.http.AmazonRootCA1: Reading...
data.http.AmazonRootCA1: Read complete after 1s [id=https://www.amazontrust.com/repository/AmazonRootCA1.pem]
data.aws_iot_endpoint.thing_mqtt: Reading...
data.aws_iam_policy_document.aws_iot_thing_policy: Reading...
data.aws_iam_policy_document.aws_iot_thing_policy: Read complete after 0s [id=1876646234]
data.aws_iot_endpoint.thing_mqtt: Read complete after 1s [id=aaaabbbbcccc.iot.us-west-1.amazonaws.com]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iot_certificate.thing will be created
  + resource "aws_iot_certificate" "thing" {
      + active          = true
      + arn             = (known after apply)
      + certificate_pem = (sensitive value)
      + id              = (known after apply)
      + private_key     = (sensitive value)
      + public_key      = (sensitive value)
    }

  # aws_iot_policy.thing will be created
  + resource "aws_iot_policy" "thing" {
      + arn                = (known after apply)
      + default_version_id = (known after apply)
      + id                 = (known after apply)
      + name               = "CloudgateCertPolicy"
      + policy             = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = "iot:Connect"
                      + Effect   = "Allow"
                      + Resource = "arn:aws:iot:us-west-1:123456789012:client/${iot:Connection.Thing.ThingName}"
                      + Sid      = ""
                    },
                  + {
                      + Action   = [
                          + "iot:Subscribe",
                          + "iot:Receive",
                          + "iot:Publish",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:iot:us-west-1:123456789012:topic/cloudgate/${iot:Connection.Thing.ThingName}"
                      + Sid      = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
    }

  # aws_iot_policy_attachment.cert_policy_attach will be created
  + resource "aws_iot_policy_attachment" "cert_policy_attach" {
      + id     = (known after apply)
      + policy = "CloudgateCertPolicy"
      + target = (known after apply)
    }

  # aws_iot_thing.thing[0] will be created
  + resource "aws_iot_thing" "thing" {
      + arn               = (known after apply)
      + default_client_id = (known after apply)
      + id                = (known after apply)
      + name              = "CG_Thing01"
      + version           = (known after apply)
    }

  # aws_iot_thing.thing[1] will be created
  + resource "aws_iot_thing" "thing" {
      + arn               = (known after apply)
      + default_client_id = (known after apply)
      + id                = (known after apply)
      + name              = "CG_Thing02"
      + version           = (known after apply)
    }

  # aws_iot_thing.thing[2] will be created
  + resource "aws_iot_thing" "thing" {
      + arn               = (known after apply)
      + default_client_id = (known after apply)
      + id                = (known after apply)
      + name              = "CG_Thing03"
      + version           = (known after apply)
    }

  # aws_iot_thing_principal_attachment.thing_cert_attach[0] will be created
  + resource "aws_iot_thing_principal_attachment" "thing_cert_attach" {
      + id        = (known after apply)
      + principal = (known after apply)
      + thing     = "CG_Thing01"
    }

  # aws_iot_thing_principal_attachment.thing_cert_attach[1] will be created
  + resource "aws_iot_thing_principal_attachment" "thing_cert_attach" {
      + id        = (known after apply)
      + principal = (known after apply)
      + thing     = "CG_Thing02"
    }

  # aws_iot_thing_principal_attachment.thing_cert_attach[2] will be created
  + resource "aws_iot_thing_principal_attachment" "thing_cert_attach" {
      + id        = (known after apply)
      + principal = (known after apply)
      + thing     = "CG_Thing03"
    }

Plan: 9 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + AmazonRootCA1_response = <<-EOT
        -----BEGIN CERTIFICATE-----
        MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
        ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
        b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
        MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
        b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
        ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
        9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
        IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
        VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
        93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
        jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
        AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
        A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
        U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
        N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
        o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
        5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
        rqXRfboQnoZsG4q5WTP468SQvvG5
        -----END CERTIFICATE-----
    EOT
  + iot_endpoint           = "aaaabbbbcccc.iot.us-west-1.amazonaws.com"
  + thing_arn              = [
      + (known after apply),
      + (known after apply),
      + (known after apply),
    ]
  + thing_cert             = (sensitive value)
  + thing_cert_pubkey      = (sensitive value)
  + thing_name             = [
      + "CG_Thing01",
      + "CG_Thing02",
      + "CG_Thing03",
    ]
  + thing_pvtkey           = (sensitive value)
aws_iot_thing.thing[0]: Creating...
aws_iot_thing.thing[2]: Creating...
aws_iot_policy.thing: Creating...
aws_iot_thing.thing[1]: Creating...
aws_iot_certificate.thing: Creating...
aws_iot_thing.thing[1]: Creation complete after 1s [id=CG_Thing02]
aws_iot_thing.thing[2]: Creation complete after 1s [id=CG_Thing03]
aws_iot_policy.thing: Creation complete after 1s [id=CloudgateCertPolicy]
aws_iot_thing.thing[0]: Creation complete after 1s [id=CG_Thing01]
aws_iot_certificate.thing: Creation complete after 2s [id=675b69b7148293acac9cb897017db47cacdcbabf33cdcf96d99e5bcac693ffc3]
aws_iot_thing_principal_attachment.thing_cert_attach[1]: Creating...
aws_iot_policy_attachment.cert_policy_attach: Creating...
aws_iot_thing_principal_attachment.thing_cert_attach[2]: Creating...
aws_iot_thing_principal_attachment.thing_cert_attach[0]: Creating...
aws_iot_thing_principal_attachment.thing_cert_attach[1]: Creation complete after 0s [id=CG_Thing02|arn:aws:iot:us-west-1:123456789012:cert/675b69b7148293acac9cb897017db47cacdcbabf33cdcf96d99e5bcac693ffc3]
aws_iot_thing_principal_attachment.thing_cert_attach[0]: Creation complete after 0s [id=CG_Thing01|arn:aws:iot:us-west-1:123456789012:cert/675b69b7148293acac9cb897017db47cacdcbabf33cdcf96d99e5bcac693ffc3]
aws_iot_thing_principal_attachment.thing_cert_attach[2]: Creation complete after 0s [id=CG_Thing03|arn:aws:iot:us-west-1:123456789012:cert/675b69b7148293acac9cb897017db47cacdcbabf33cdcf96d99e5bcac693ffc3]
aws_iot_policy_attachment.cert_policy_attach: Creation complete after 0s [id=CloudgateCertPolicy|arn:aws:iot:us-west-1:123456789012:cert/675b69b7148293acac9cb897017db47cacdcbabf33cdcf96d99e5bcac693ffc3]

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

AmazonRootCA1_response = <<EOT
-----BEGIN CERTIFICATE-----
MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
rqXRfboQnoZsG4q5WTP468SQvvG5
-----END CERTIFICATE-----

EOT
iot_endpoint = "aaaabbbbcccc.iot.us-west-1.amazonaws.com"
thing_arn = [
  "arn:aws:iot:us-west-1:123456789012:thing/CG_Thing01",
  "arn:aws:iot:us-west-1:123456789012:thing/CG_Thing02",
  "arn:aws:iot:us-west-1:123456789012:thing/CG_Thing03",
]
thing_cert = <sensitive>
thing_cert_pubkey = <sensitive>
thing_name = [
  "CG_Thing01",
  "CG_Thing02",
  "CG_Thing03",
]
thing_pvtkey = <sensitive>
```
</details><br>

**Step 5.** Terraform output  
`terraform output -raw iot_endpoint`

```
aaaabbbbcccc.iot.us-west-1.amazonaws.com
```  

`terraform output -raw AmazonRootCA1_response`  
```
-----BEGIN CERTIFICATE-----
MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
...
-----END CERTIFICATE-----
```
***Use `jq` command to find certificates and keys for each thing:***  
  
`terraform output -json thing_cert| jq -r '.[0]'`  
```            
-----BEGIN CERTIFICATE-----
MIIDWjCCAkKgAwIBAgIVAMmk4SRpXD7uFz6N5tmbBPLE3QBAMA0GCSqGSIb3DQEB
CwUAME0xSzBJBgNVBAsMQkFtYXpvbiBXZWIgU2VydmljZXMgTz1BbWF6b24uY29t
IEluYy4gTD1TZWF0dGxlIFNUPVdhc2hpbmd0b24gQz1VUzAeFw0yMjA5MTEwNDM1
...
-----END CERTIFICATE-----
```
> For additional certificates : `terraform output -json thing_cert| jq -r '.[1]'`, `terraform output -json thing_cert| jq -r '.[2]'`  and so on. 


`terraform output -json thing_pvtkey| jq -r '.[0]'`  
```
-----BEGIN RSA PRIVATE KEY-----
MIIEpgIBAAKCAQEA5iDaSydrOw4eRJ8gypV1PQXlpzc4EXTYxwBBWrGb+V5uRNWx
Ps1JbTnhiDV7tEboQmLR1iK9y6pJwbV5gzOFC9KVAAYa/6DdJPhV2FpTredUe/t7
EQUCWedjK5BNE7877u0M7b6w78rSheIlgvMa6tsssvIGAVyZk9VyqCz/SibVSu0m
...
-----END RSA PRIVATE KEY-----
```

> For additional Private keys : `terraform output -json thing_pvtkey| jq -r '.[1]'`, `terraform output -json thing_pvtkey| jq -r '.[2]''`  and so on. 


<img src="./images/thing.png" alt="Thing" style="width:800px;"/>
<br>
<img src="./images/certificate.png" alt="Certificate" style="width:800px;"/>
<br>
<img src="./images/policy.png" alt="Policy" style="width:800px;"/>
<br>


---
# Checkov scan

**Step 1.**  `terraform init`  

  <details>
  <summary><b>Initializing output</b></summary>
  
    Initializing the backend...

    Initializing provider plugins...
    - Finding latest version of hashicorp/aws...
    - Finding latest version of hashicorp/http...
    - Installing hashicorp/aws v4.30.0...
    - Installed hashicorp/aws v4.30.0 (signed by HashiCorp)
    - Installing hashicorp/http v3.1.0...
    - Installed hashicorp/http v3.1.0 (signed by HashiCorp)

    Terraform has created a lock file .terraform.lock.hcl to record the provider
    selections it made above. Include this file in your version control repository
    so that Terraform can guarantee to make the same selections by default when
    you run "terraform init" in the future.

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
  </details><br>

**Step 2.**  `terraform plan -var-file="VegasGate02.tfvars" --out tfplan.binary`

  <details>
  <summary><b>Plan output</b></summary>  

    data.http.AmazonRootCA1: Reading...
    data.http.AmazonRootCA1: Read complete after 1s [id=https://www.amazontrust.com/repository/AmazonRootCA1.pem]
    data.aws_iot_endpoint.thing_mqtt: Reading...
    data.aws_iam_policy_document.aws_iot_thing_policy: Reading...
    data.aws_iam_policy_document.aws_iot_thing_policy: Read complete after 0s [id=305099920]
    data.aws_iot_endpoint.thing_mqtt: Read complete after 1s [id=aaaabbbbcccc.iot.us-west-1.amazonaws.com]

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # aws_iot_certificate.thing will be created
      + resource "aws_iot_certificate" "thing" {
          + active          = true
          + arn             = (known after apply)
          + certificate_pem = (sensitive value)
          + id              = (known after apply)
          + private_key     = (sensitive value)
          + public_key      = (sensitive value)
        }

      # aws_iot_policy.thing will be created
      + resource "aws_iot_policy" "thing" {
          + arn                = (known after apply)
          + default_version_id = (known after apply)
          + id                 = (known after apply)
          + name               = "VegasGate02_certPolicy"
          + policy             = jsonencode(
                {
                  + Statement = [
                      + {
                          + Action   = "iot:Connect"
                          + Effect   = "Allow"
                          + Resource = "arn:aws:iot:us-west-1:123456789012:client/${iot:Connection.Thing.ThingName}"
                          + Sid      = ""
                        },
                      + {
                          + Action   = [
                              + "iot:Subscribe",
                              + "iot:Receive",
                              + "iot:Publish",
                            ]
                          + Effect   = "Allow"
                          + Resource = "arn:aws:iot:us-west-1:123456789012:topic/cg/${iot:Connection.Thing.ThingName}"
                          + Sid      = ""
                        },
                    ]
                  + Version   = "2012-10-17"
                }
            )
        }

      # aws_iot_policy_attachment.cert_policy_attach will be created
      + resource "aws_iot_policy_attachment" "cert_policy_attach" {
          + id     = (known after apply)
          + policy = "VegasGate02_certPolicy"
          + target = (known after apply)
        }

      # aws_iot_thing.thing will be created
      + resource "aws_iot_thing" "thing" {
          + arn               = (known after apply)
          + default_client_id = (known after apply)
          + id                = (known after apply)
          + name              = "VegasGate02"
          + version           = (known after apply)
        }

      # aws_iot_thing_principal_attachment.thing_cert_attach will be created
      + resource "aws_iot_thing_principal_attachment" "thing_cert_attach" {
          + id        = (known after apply)
          + principal = (known after apply)
          + thing     = "VegasGate02"
        }

    Plan: 5 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
      + AmazonRootCA1_response = <<-EOT
            -----BEGIN CERTIFICATE-----
            MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
            ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
            b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
            MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
            b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
            ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
            9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
            IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
            VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
            93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
            jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
            AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
            A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
            U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
            N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
            o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
            5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
            rqXRfboQnoZsG4q5WTP468SQvvG5
            -----END CERTIFICATE-----
        EOT
      + iot_endpoint           = "aaaabbbbcccc.iot.us-west-1.amazonaws.com"
      + thing_arn              = (known after apply)
      + thing_cert             = (sensitive value)
      + thing_cert_pubkey      = (sensitive value)
      + thing_name             = "VegasGate02"
      + thing_pvtkey           = (sensitive value)

    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

    Saved the plan to: tfplan.binary

    To perform exactly these actions, run the following command to apply:
        terraform apply "tfplan.binary"
</details><br>


**Step 3.** `terraform show -json tfplan.binary > tfplan.json`
```
ls -lh
total 168
-rw-r--r--  1 atulac  staff   8.3K Sep 10 21:08 README.md
-rw-r--r--  1 atulac  staff   120B Sep 10 20:08 VegasGate02.tfvars
-rw-r--r--  1 atulac  staff   780B Sep 10 20:10 data.tf
-rw-r--r--  1 atulac  staff   686B Sep 10 19:40 main.tf
-rw-r--r--  1 atulac  staff   596B Sep 10 20:34 output.tf
-rw-r--r--  1 atulac  staff   157B Sep 10 20:34 terraform.tfstate
-rw-r--r--  1 atulac  staff    19K Sep 10 20:34 terraform.tfstate.backup
-rw-r--r--  1 atulac  staff   7.9K Sep 10 20:51 tfplan.binary
-rw-r--r--  1 atulac  staff    19K Sep 10 20:51 tfplan.json
-rw-r--r--  1 atulac  staff   369B Sep 10 20:35 variables.tf
```
