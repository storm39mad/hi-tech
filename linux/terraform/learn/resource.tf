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