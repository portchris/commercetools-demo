terraform {
    required_providers {
        commercetools = {
            source = "labd/commercetools"
            version = "1.15.1"
        }
    }
}

variable "ctp_project_key" {
  type = string
}

variable "ctp_client_id" {
  type = string
}

variable "ctp_client_secret" {
  type = string
}

variable "ctp_scopes" {
  type = string
}

variable "ctp_api_url" {
  type = string
}

variable "ctp_auth_url" {
  type = string
}

variable "ctp_debug" {
  type = string
}

provider "commercetools" {
    project_key = "${var.ctp_project_key}"
    client_id = "${var.ctp_client_id}"
    client_secret = "${var.ctp_client_secret}"
    scopes = "${var.ctp_scopes}"
    api_url = "${var.ctp_api_url}"
    token_url = "${var.ctp_auth_url}"
}
