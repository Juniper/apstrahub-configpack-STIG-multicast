#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

terraform {
  required_providers {
    apstra = {
      source  = "Juniper/apstra"
      version = "0.92.2"
    }
  }
}

variable "blueprint_name" {
  type = string
}

resource "apstra_datacenter_blueprint" "a" {
  name        = var.blueprint_name
  template_id = "L3_Collapsed_ACS"
}

resource "apstra_datacenter_device_allocation" "leaf" {
  blueprint_id             = apstra_datacenter_blueprint.a.id
  node_name                = "collapsed_1xleaf_001_leaf1"
  initial_interface_map_id = "Juniper_vQFX__AOS-7x10-Leaf"
}

output "blueprint_id" {
  value = apstra_datacenter_blueprint.a.id
}

output "node_id" {
  value = apstra_datacenter_device_allocation.leaf.node_id
}
