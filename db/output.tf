output "public_ip" {
  value = aws_instance.db.public_ip
}
output "public_dns" {
  value = aws_instance.db.public_dns
}