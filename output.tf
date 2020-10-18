locals {
  api_list = ["${split("\r\n", module.files.stdout)}"]
}

output "my_ip" {
  value =  local.api_list
}

locals {
  white_list=  [for x in local.api_list:
    "${formatlist("%s/32", x)}"
  ]
}

output "my_white_list" {
  value = local.white_list
}

