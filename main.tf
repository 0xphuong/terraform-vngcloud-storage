locals {
  expanded_volumes = flatten([
    for volume_name, config in var.volumes.volume_configs : [
      for i in range(config.count) : {
        key       = "${volume_name}-${i}"
        name      = "${volume_name}-${i}"
        size      = config.size
        server_id = config.server_id
        zone_id   = config.zone_id != null ? config.zone_id : var.volumes.zone_id
      }
    ]
  ])

  volume_map = { for v in local.expanded_volumes : v.key => v }

  attachable_volumes = {
    for k, v in local.volume_map : k => v
    if v.server_id != null
  }
}

resource "vngcloud_vserver_volume" "this" {
  for_each = local.volume_map

  project_id     = var.project_id
  name           = each.value.name
  size           = each.value.size
  volume_type_id = var.volumes.volume_type_id

  # Optional
  zone_id = each.value.zone_id != null ? each.value.zone_id : null

  lifecycle {
    create_before_destroy = true
  }
}

resource "vngcloud_vserver_volume_attach" "this" {
  for_each = local.attachable_volumes

  project_id = var.project_id
  volume_id  = vngcloud_vserver_volume.this[each.key].id
  server_id  = each.value.server_id
}
