
variable "clients_whitelist_ip" {
    description = "whitelist"
    default = ["8.8.8.8/24", "8.8.8.8/24"]
}

variable "network_id" {
    description = "network_id"
    default = "enprje4rmqdrfcg9hu42"
}

variable "api_url" {
    type        = string
    description = "api url "
    default = "https://lms.schooleducation.online/webservice/rest/server.php"
}

variable "wstoken" {
    type        = string
    description = "wstoken"
    default = "258d9b937589677ca24d3c6b7aeff592"
}

variable "wsfunction" {
    type        = string
    description = "wsfunction"
    default = "local_og_get_users_lastip"
}

variable "moodlewsrestformat" {
    type        = string
    description = "moodlewsrestformat"
    default = "json"
}

variable "text" {
    type        = string
    description = "text"
    default = "1"
}