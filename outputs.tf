output "volume_ids" {
  description = "Map of volume key => volume ID"
  value       = { for k, v in vngcloud_vserver_volume.this : k => v.id }
}

output "volume_names" {
  description = "Map of volume key => volume name"
  value       = { for k, v in vngcloud_vserver_volume.this : k => v.name }
}

output "volume_sizes" {
  description = "Map of volume key => volume size in GB"
  value       = { for k, v in vngcloud_vserver_volume.this : k => v.size }
}

output "attachment_ids" {
  description = "Map of volume key => attachment ID (only attached volumes)"
  value       = { for k, v in vngcloud_vserver_volume_attach.this : k => v.id }
}
