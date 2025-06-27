# terraform/variables.tf

variable "aws_region" {
  description = "Região AWS onde os recursos serão provisionados"
  type        = string
  default     = "us-east-1" # Escolha a região mais próxima de você ou que prefere
}

variable "project_name" {
  description = "Nome do projeto para identificação dos recursos"
  type        = string
  default     = "api-estoque-devops"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro" # t2.micro é elegível para o Free Tier
}

variable "api_port" {
  description = "Porta em que a API Node.js estará rodando"
  type        = number
  default     = 3000 # Sua API Node.js está configurada para esta porta
}

variable "public_key_path" {
  description = "Caminho absoluto ou relativo para o arquivo de chave pública SSH (.pub)"
  type        = string
  # Exemplo: ~/.ssh/id_rsa.pub. Crie um par de chaves SSH se não tiver: ssh-keygen -t rsa -b 4096 -f ~/.ssh/api-estoque-key
  # Certifique-se de que o arquivo existe e o caminho está correto.
  default = "~/.ssh/api-estoque-key.pub"
}
