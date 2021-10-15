variable "string_length" {
  type = number
  default = 15
}

variable "path" {
  type = string
  default = "/home/user/test.txt"
}

resource "random_string" "mystring" {
  length = var.string_length
}

resource "local_file" "myfile" {
  filename = var.path
  content = random_string.mystring.id
}

data "local_file" "hostname" {
    filename = "/etc/hostname"
}

output "hostname" {
  value = data.local_file.hostname.content
}

output "mystring" {
    value = random_string.mystring.id
}