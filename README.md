Demo Commercetools + Terraform store
======================================

This repository aims to demonstrate how to use [Terraform](https://registry.terraform.io/) to orchestrate [Commercetools](https://commercetools.com/) using it's powerful declarative schemas by utilising the [labd/commercetools](https://registry.terraform.io/providers/labd/commercetools/latest) provider.

## Prerequisites
Requires the `terraform` CLI tool. [See guide here on how to install](https://developer.hashicorp.com/terraform/install).

Additionally, you are going to need to sign up for the [60-day free trial](https://commercetools.com/free-trial) of `commercetools` and generate an API client to access specific keys in order to drive this


## Installation

Firstly, you need to ensure the following `.env` variables are present in your project:
```env
TF_VAR_ctp_project_key=
TF_VAR_ctp_client_id=
TF_VAR_ctp_client_secret=
TF_VAR_ctp_scopes=
TF_VAR_ctp_api_url=
TF_VAR_ctp_auth_url=
TF_VAR_ctp_debug=1
```

Secondly, initialise `terraform`:
```bash
terraform init
```

Thirdly, stage and list changes that can be applied:
```bash
terraform plan
```

Finally, apply those changes and push to your `commercetools` project:
```bash
terraform apply
```

## Extending

The [labd/commercetools](https://registry.terraform.io/providers/labd/commercetools/latest) Terraform provider allows you [extend commercetools in these ways](https://registry.terraform.io/providers/labd/commercetools/latest/docs). In this example we merely [add a category](https://registry.terraform.io/providers/labd/commercetools/latest/docs/resources/category) but, there are so many other resources here to sink your teeth into.