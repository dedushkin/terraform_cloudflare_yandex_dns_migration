provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "yandex" {
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  token     = var.yandex_token
}