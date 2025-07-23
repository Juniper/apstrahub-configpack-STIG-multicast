#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_datacenter_configlet" "a" {
  blueprint_id = var.blueprint_id
  condition = "role in [\"leaf\", \"access\"]"
  name = var.name
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_hierarchical"
      template_text = <<-EOT
        protocols {
          replace: igmp-snooping {
            vlan all;
          }
          replace: mld-snooping {
            vlan all;
          }
        }
      EOT
    },
  ]
}
