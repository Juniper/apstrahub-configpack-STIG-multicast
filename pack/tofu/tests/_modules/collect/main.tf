#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

terraform {
  required_providers {
    apstra = {
      source = "Juniper/apstra"
      version = "0.92.2"
    }
  }
}

variable "blueprint_id" {
  type = string
}

variable "node_id" {
  type = string
}

data "apstra_blueprint_device_rendered_config" "leaf" {
  blueprint_id = var.blueprint_id
  node_id = var.node_id
}

# output "igmp_snooping_found" {
#   value = strcontains(data.apstra_blueprint_device_rendered_config.leaf.staged_config, "igmp-snooping")
# }