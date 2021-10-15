resource "local_file" "myfile" {
  filename = "/home/user/test.txt"
  content = "My first terraform resource"
}