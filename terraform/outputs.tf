# terraform/outputs.tf

output "public_ip_instance" {
  description = "Endereço IP público da instância EC2"
  value       = aws_instance.api_instance.public_ip
}

output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.api_instance.id
}

output "security_group_id" {
  description = "ID do Security Group da API"
  value       = aws_security_group.api_security_group.id
}

output "key_pair_name" {
  description = "Nome do par de chaves SSH"
  value       = aws_key_pair.api_key_pair.key_name
}
