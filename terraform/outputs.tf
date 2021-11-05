
output "web_server_instance_id" {
  value = aws_instance.my_webserver.id
}

output "web_public_ip" {
  value = aws_eip.my_static_ip.public_ip
}
