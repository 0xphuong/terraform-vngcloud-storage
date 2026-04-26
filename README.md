# terraform-vngcloud-storage

Terraform module to provision **block storage volumes** and attach them to vServer instances on [VNG Cloud](https://vngcloud.vn).

## Features

- Multi-volume provisioning using a map-based config (one call, many volumes)
- Optional auto-attach: provide `server_id` to attach on creation, omit to create standalone
- Input validation: count ≥ 1, size ≥ 10 GB
- Structured outputs: IDs, names, sizes, attachment IDs

## Usage

### Basic — standalone volumes

```hcl
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
```

### Complete — multiple groups, some attached

```hcl
module "storage" {
  source = "github.com/0xphuong/terraform-vngcloud-storage?ref=v1.0.0"

  project_id = var.project_id

  volumes = {
    volume_type_id = var.nvme_disk_type_id

    volume_configs = {
      mongodb-data = {
        count     = 1
        size      = 200
        server_id = module.vserver.server_ids["mongodb-0"]
      }
      app-data = {
        count = 2
        size  = 100
      }
      backup = {
        count = 1
        size  = 500
      }
    }
  }
}
```

### Use with terraform-vngcloud-vserver

```hcl
module "vserver" {
  source = "github.com/0xphuong/terraform-vngcloud-vserver?ref=v1.0.0"
  # ...
}

module "storage" {
  source     = "github.com/0xphuong/terraform-vngcloud-storage?ref=v1.0.0"
  project_id = var.project_id

  volumes = {
    volume_type_id = var.disk_type_id
    volume_configs = {
      db-data = {
        count     = 1
        size      = 200
        server_id = module.vserver.server_ids["db-0"]
      }
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| vngcloud | >= 1.2.7 |

## Providers

| Name | Version |
|------|---------|
| vngcloud | >= 1.2.7 |

## Resources

| Name | Type |
|------|------|
| vngcloud_vserver_volume.this | resource |
| vngcloud_vserver_volume_attach.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project\_id | VNG Cloud project ID | `string` | — | yes |
| volumes | Shared volume params + per-volume configurations | `object` | — | yes |

### `volumes` object

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `volume_type_id` | `string` | — | Disk type ID (e.g. NVMe, SSD) |
| `volume_configs` | `map(object)` | — | Per-group volume config |

### `volume_configs` map value

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `count` | `number` | — | Number of volumes to create (min 1) |
| `size` | `number` | — | Size in GB (min 10) |
| `server_id` | `string` | `null` | Server ID to attach to. Omit to create standalone |

## Outputs

| Name | Description |
|------|-------------|
| volume\_ids | Map of volume key => volume ID |
| volume\_names | Map of volume key => volume name |
| volume\_sizes | Map of volume key => size in GB |
| attachment\_ids | Map of volume key => attachment ID (only attached volumes) |
<!-- END_TF_DOCS -->

## Examples

- [Basic](./examples/basic) — create standalone volumes
- [Complete](./examples/complete) — multiple groups with optional attachment

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md).

## Changelog

See [CHANGELOG.md](./CHANGELOG.md).

## License

[MIT](./LICENSE)
