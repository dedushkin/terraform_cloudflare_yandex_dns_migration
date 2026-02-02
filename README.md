Tool for migrating DNS zones and records from Cloudflare to Yandex Cloud

# Usage

`terraform plan -out=tfplan -var-file=.tfvars -var="cloudflare_token=$CF_TOKEN" -var="yandex_token=$YC_TOKEN"`

`terraform apply tfplan`

**Note:** To transfer a domain name containing non-Latin characters, use Punycode encoding.

⚠️ **CAA** records may cause crashes. Exclude them manually using filters.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.181 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 5.16.0 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.181.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_dns_recordset.records](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_recordset) | resource |
| [yandex_dns_zone.zones](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_zone) | resource |
| [cloudflare_dns_records.all_records](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/dns_records) | data source |
| [cloudflare_zones.target_zones](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_dns_records_comment_filter"></a> [cloudflare\_dns\_records\_comment\_filter](#input\_cloudflare\_dns\_records\_comment\_filter) | Filter DNS records by comment:<br/>    cloudflare\_dns\_records\_comment\_filter = {<br/>      absent = "absent"<br/>      contains = "ello, worl"<br/>      endswith = "o, world"<br/>      exact = "Hello, world"<br/>      present = "present"<br/>      startswith = "Hello, w"<br/>    } | `map(string)` | `{}` | no |
| <a name="input_cloudflare_dns_records_content_filter"></a> [cloudflare\_dns\_records\_content\_filter](#input\_cloudflare\_dns\_records\_content\_filter) | Filter DNS records by content:<br/>    cloudflare\_dns\_records\_content\_filter = {<br/>      contains = "7.0.0."<br/>      endswith = ".0.1"<br/>      exact = "127.0.0.1"<br/>      startswith = "127.0."<br/>    } | `map(string)` | `{}` | no |
| <a name="input_cloudflare_dns_records_name_filter"></a> [cloudflare\_dns\_records\_name\_filter](#input\_cloudflare\_dns\_records\_name\_filter) | Filter DNS records by name:<br/>    cloudflare\_dns\_records\_name\_filter = {<br/>      contains = "w.example."<br/>      endswith = ".example.com"<br/>      exact = "www.example.com"<br/>      startswith = "www.example"<br/>    } | `map(string)` | `{}` | no |
| <a name="input_cloudflare_dns_records_tag_filter"></a> [cloudflare\_dns\_records\_tag\_filter](#input\_cloudflare\_dns\_records\_tag\_filter) | Filter DNS records by tag:<br/>    cloudflare\_dns\_records\_tag\_filter = {<br/>      absent = "important"<br/>      contains = "greeting:ello, worl"<br/>      endswith = "greeting:o, world"<br/>      exact = "greeting:Hello, world"<br/>      present = "important"<br/>      startswith = "greeting:Hello, w"<br/>    } | `map(string)` | `{}` | no |
| <a name="input_cloudflare_token"></a> [cloudflare\_token](#input\_cloudflare\_token) | API Token for Cloudflare | `string` | n/a | yes |
| <a name="input_yandex_cloud_id"></a> [yandex\_cloud\_id](#input\_yandex\_cloud\_id) | Yandex Cloud ID | `string` | n/a | yes |
| <a name="input_yandex_dns_zone_labels"></a> [yandex\_dns\_zone\_labels](#input\_yandex\_dns\_zone\_labels) | Labels to apply to Yandex DNS zones | `map(string)` | <pre>{<br/>  "migrated": "cloudflare"<br/>}</pre> | no |
| <a name="input_yandex_folder_id"></a> [yandex\_folder\_id](#input\_yandex\_folder\_id) | Yandex Folder ID | `string` | n/a | yes |
| <a name="input_yandex_token"></a> [yandex\_token](#input\_yandex\_token) | OAuth token for Yandex Cloud | `string` | n/a | yes |
| <a name="input_zone_list"></a> [zone\_list](#input\_zone\_list) | List of zones to migrate | `list(string)` | n/a | yes |

## Outputs

No outputs.