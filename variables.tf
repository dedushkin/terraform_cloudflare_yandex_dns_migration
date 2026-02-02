variable "cloudflare_token" {
  type        = string
  description = "API Token for Cloudflare"
  sensitive   = true
}

variable "yandex_token" {
  type        = string
  description = "OAuth token for Yandex Cloud"
  sensitive   = true
}

variable "yandex_cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "yandex_folder_id" {
  type        = string
  description = "Yandex Folder ID"
}

variable "zone_list" {
  type        = list(string)
  description = "List of zones to migrate"
}

variable "cloudflare_dns_records_comment_filter" {
  type        = map(string)
  default     = {}
  description = <<EOF
  Filter DNS records by comment:
    cloudflare_dns_records_comment_filter = {
      absent = "absent"
      contains = "ello, worl"
      endswith = "o, world"
      exact = "Hello, world"
      present = "present"
      startswith = "Hello, w"
    }
  EOF
}

variable "cloudflare_dns_records_content_filter" {
  type        = map(string)
  default     = {}
  description = <<EOF
  Filter DNS records by content:
    cloudflare_dns_records_content_filter = {
      contains = "7.0.0."
      endswith = ".0.1"
      exact = "127.0.0.1"
      startswith = "127.0."
    }
  EOF
}

variable "cloudflare_dns_records_name_filter" {
  type        = map(string)
  default     = {}
  description = <<EOF
  Filter DNS records by name:
    cloudflare_dns_records_name_filter = {
      contains = "w.example."
      endswith = ".example.com"
      exact = "www.example.com"
      startswith = "www.example"
    }
  EOF
}

variable "cloudflare_dns_records_tag_filter" {
  type        = map(string)
  default     = {}
  description = <<EOF
  Filter DNS records by tag:
    cloudflare_dns_records_tag_filter = {
      absent = "important"
      contains = "greeting:ello, worl"
      endswith = "greeting:o, world"
      exact = "greeting:Hello, world"
      present = "important"
      startswith = "greeting:Hello, w"
    }
  EOF
}

variable "yandex_dns_zone_labels" {
  type = map(string)
  default = {
    migrated = "cloudflare"
  }
  description = "Labels to apply to Yandex DNS zones"
}