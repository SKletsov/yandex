data "yandex_vpc_network" "this" {
  network_id = var.network_id
}

module "files" {
  source  = "matti/resource/shell"
  command = <<EOT
        curl --location --request POST ${var.api_url} \
        --form 'wstoken=${var.wstoken}' \
        --form 'wsfunction=${var.wsfunction}' \
        --form 'moodlewsrestformat=${var.moodlewsrestformat}' \
        --form 'text=${var.text}'
        EOT
}

resource "yandex_vpc_security_group" "allowed_clients" {
  name        = "allowed_clients_sg"
  description = "allow traffic from trusted clients"
  network_id  = data.yandex_vpc_network.this.id

  labels = {
    type = "client-whitelist"
  }

  ingress {
    protocol       = "TCP"
    description    = "internal_net_ssh"
    v4_cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "internal_net_rdp"
    v4_cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"]
    port           = 3389
  }

  ingress {
    protocol       = "TCP"
    description    = "tcp_clients_list"
    v4_cidr_blocks = ["1.1.1.1/32", "1.1.2.0/24"]
    from_port      = 1
    to_port        = 65535
  }

  ingress {
    protocol       = "UDP"
    description    = "udp_clients_list"
    v4_cidr_blocks = ["1.1.1.1/32", "1.1.2.0/24"]
    from_port      = 1
    to_port        = 65535
  }

  ingress {
    protocol       = "UDP"
    description    = "udp_mosh_term"
    v4_cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"]
    from_port      = 60000
    to_port        = 61000
  }


  ingress {
    protocol          = "TCP"
    description       = "p2p"
    predefined_target = "self_security_group"
    port              = "22"
  }

  egress {
    protocol       = "ANY"
    description    = "egress_internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 1
    to_port        = 65535
  }
}