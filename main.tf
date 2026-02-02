data "cloudflare_zones" "target_zones" {
  for_each = toset(var.zone_list)

  name = each.key
}

data "cloudflare_dns_records" "all_records" {
  for_each = toset(var.zone_list)

  zone_id = data.cloudflare_zones.target_zones[each.key].result[0].id
  comment = var.cloudflare_dns_records_comment_filter
  content = var.cloudflare_dns_records_content_filter
  name    = var.cloudflare_dns_records_name_filter
  tag     = var.cloudflare_dns_records_tag_filter
}

locals {
  processed_records_flat = flatten([
    for domain in var.zone_list : [
      for record in data.cloudflare_dns_records.all_records[domain].result : {
        domain = domain
        name   = record.name
        type   = record.type
        ttl    = record.ttl

        # Formatting content for YC:
        # 1. MX, SRV: Prepend priority.
        # 2. TXT: Enclose each one if not already quoted.
        # 3. Others: Raw content.
        content = (
          record.type == "MX" ? "${record.priority} ${record.content}" :
          record.type == "SRV" ? "${record.priority} ${record.content}" :
          record.type == "TXT" ?
          (
            startswith(record.content, "\"") && endswith(record.content, "\"") ?
            record.content :
            "\"${record.content}\""
          ) :
          record.content
        )
      }
      if record.type != "SOA" && record.type != "NS"
    ]
  ])

  grouped_records = {
    for record in local.processed_records_flat :
    sha256("${record.domain}.${record.name}.${record.type}") => record...
  }
}

resource "yandex_dns_zone" "zones" {
  for_each = toset(var.zone_list)

  zone   = "${each.key}."
  name   = replace(each.key, ".", "-")
  labels = var.yandex_dns_zone_labels
  public = true
}

resource "yandex_dns_recordset" "records" {
  for_each = local.grouped_records

  zone_id = yandex_dns_zone.zones[each.value[0].domain].id
  name    = "${each.value[0].name}."
  type    = each.value[0].type
  ttl     = each.value[0].ttl <= 1 ? 300 : each.value[0].ttl
  data    = each.value[*].content
}

