#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

# Create a blueprint and assign a device profile to a leaf switch.
run "prerequisites" {
  command = apply

  variables {
    blueprint_name = "bp_name"
  }

  module {
    source = "./tests/_modules/prerequisites"
  }
}

# Deploy our pack.
run "deploy_pack" {
  command = apply

  variables {
    blueprint_id = run.prerequisites.blueprint_id
    name         = "configlet name"
  }
}

# Inspect the rendered config for our leaf switch, ensure that the Junos
# directives in the configlet appear in our leaf switch rendered config.
run "collect" {
  command = apply

  module {
    source = "./tests/_modules/collect"
  }

  variables {
    blueprint_id = run.prerequisites.blueprint_id
    node_id      = run.prerequisites.node_id
  }

  assert {
    condition     = strcontains(data.apstra_blueprint_device_rendered_config.leaf.staged_config, "igmp-snooping")
    error_message = "`igmp-snooping` not found in staged configuration"
  }
}
