terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">= 2.6.0"
    }
    utils = {
      source  = "netascode/utils"
      version = ">= 0.2.4"
    }
  }
}

terraform {
  backend "http" {
  }
}

provider "aci" {
}

locals {
  model = yamldecode(data.utils_yaml_merge.model.output)
}

data "utils_yaml_merge" "model" {
  input = concat([for file in fileset(path.module, "data/*.yaml") : file(file)], [file("${path.module}/defaults/defaults.yaml"), file("${path.module}/modules/modules.yaml")])
}

module "tenant" {
  source  = "netascode/nac-tenant/aci"
  version = ">= 0.4.1"

  for_each    = toset([for tenant in lookup(local.model.apic, "tenants", {}) : tenant.name])
  model       = local.model
  tenant_name = each.value
} 