output "vpc_security_group_ids" {
  value = aws_security_group.bgapp-pub-sg.id
}
output "subnet_id" {
  value = aws_subnet.bgapp-snet.id
}
