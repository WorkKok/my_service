terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

locals {
   cloud_id = "b1gtpfppaugk9laj5gb5"
   folder_id = "b1ge0871kp77ffglqsel"
}

provider "yandex" {
  service_account_key_file = "/home/hackir/my_service/terraform/authorized_key.json"
  cloud_id  = local.cloud_id
  folder_id = local.folder_id
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "my_app" {
  name        = "my-app-vm"
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd84aqtri79if91dbg21"   # Ubuntu 22.04 LTS
      size     = 20
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }
  metadata = {
    user-data = <<-EOT
      #cloud-config
      runcmd:
        - curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
        - docker run -d -p 80:80 --restart=always --name my_app workok/my_service:latest
    EOT
  }
}

resource "yandex_vpc_network" "my-service-network" {
  name = "my-service-network"
}

resource "yandex_vpc_subnet" "default" {
  name           = "my-service-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my-service-network.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

output "external_ip" {
  value = yandex_compute_instance.my_app.network_interface[0].nat_ip_address
  description = "Публичный IP сервера с приложением"
}
