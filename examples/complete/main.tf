module "storage" {
  source = "github.com/0xphuong/terraform-vngcloud-storage?ref=v1.0.0"

  project_id = var.project_id

  volumes = {
    volume_type_id = var.nvme_disk_type_id

    volume_configs = {
      mongodb-data = {
        count     = 1
        size      = 200
        server_id = var.mongodb_server_id
      }
      app-data = {
        count     = 2
        size      = 100
        server_id = null  # create without attaching
      }
      backup = {
        count = 1
        size  = 500
      }
    }
  }
}

output "volume_ids"    { value = module.storage.volume_ids }
output "volume_sizes"  { value = module.storage.volume_sizes }
output "attachment_ids" { value = module.storage.attachment_ids }
