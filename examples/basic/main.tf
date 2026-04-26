module "storage" {
  source = "github.com/0xphuong/terraform-vngcloud-storage?ref=v1.0.0"

  project_id = var.project_id

  volumes = {
    volume_type_id = var.disk_type_id

    volume_configs = {
      data = {
        count = 1
        size  = 50
      }
    }
  }
}

output "volume_ids" { value = module.storage.volume_ids }
