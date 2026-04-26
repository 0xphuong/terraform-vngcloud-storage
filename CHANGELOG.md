# Changelog

All notable changes to this module will be documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-04-26

### Added
- Initial release
- `vngcloud_vserver_volume` resource with `for_each` multi-volume provisioning
- `vngcloud_vserver_volume_attach` resource — auto-attach when `server_id` is provided
- Input validation: count >= 1, size >= 10 GB
- Outputs: `volume_ids`, `volume_names`, `volume_sizes`, `attachment_ids`
- Examples: `basic`, `complete`
- GitHub Actions CI: fmt, validate, tflint, docs check

### Changed
- `required_providers.tf` renamed to `versions.tf`, added `required_version = ">= 1.3.0"`
- Resource names unified to `this` (consistent with other modules)
- `outputs.tf` uncommented and changed to structured maps
- `variables.tf` added validation and explicit `default = null` for `server_id`
