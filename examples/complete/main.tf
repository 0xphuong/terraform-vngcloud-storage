module "storage" {
  source = "github.com/0xphuong/terraform-vngcloud-storage?ref=v1.0.0"

  project_id = var.project_id

  volumes = {
    volume_type_id = var.nvme_disk_type_id
    zone_id        = "HCM03-1A"   # default zone for all volumes

    volume_configs = {
      mongodb-data = {
        count     = 1
        size      = 200
        server_id = var.mongodb_server_id
        # inherits zone_id = "HCM03-1A"
      }
      app-data = {
        count     = 2
        size      = 100
        server_id = null
        zone_id   = "HCM03-1B"   # override: different zone
      }
      backup = {
        count = 1
        size  = 500
        # inherits zone_id = "HCM03-1A"
      }
    }
  }
}

output "volume_ids"    { value = module.storage.volume_ids }
output "volume_sizes"  { value = module.storage.volume_sizes }
output "attachment_ids" { value = module.storage.attachment_ids }
