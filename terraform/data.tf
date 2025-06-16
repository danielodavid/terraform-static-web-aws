data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh.tpl")

  vars = {
    html_content = file("${path.module}/index.html")
  }
}