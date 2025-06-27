# terraform/main.tf

# Define o provedor AWS e a região
provider "aws" {
  region = var.aws_region
}

# Recurso: Par de Chaves SSH
resource "aws_key_pair" "api_key_pair" {
  key_name   = "api-estoque-key" # Nome para sua chave SSH
  public_key = file(var.public_key_path) # Caminho para sua chave pública SSH local

  tags = {
    Name = "api-estoque-key"
  }
}

# Recurso: VPC (Virtual Private Cloud)
resource "aws_vpc" "api_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Recurso: Sub-rede Pública
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.api_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a" # Exemplo: us-east-1a. Escolha uma AZ válida para sua região.
  map_public_ip_on_launch = true # Ativa IPs públicos automáticos para instâncias nesta sub-rede

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

# Recurso: Internet Gateway (para acesso à internet da VPC)
resource "aws_internet_gateway" "api_igw" {
  vpc_id = aws_vpc.api_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Recurso: Tabela de Rotas para a sub-rede pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.api_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # Rota padrão para a internet
    gateway_id = aws_internet_gateway.api_igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Recurso: Associação da Tabela de Rotas com a Sub-rede Pública
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Recurso: Security Group (Grupo de Segurança)
resource "aws_security_group" "api_security_group" {
  name        = "${var.project_name}-sg"
  description = "Permitir trafego SSH e da API para a instancia EC2"
  vpc_id      = aws_vpc.api_vpc.id

  # Regra de entrada para SSH (Porta 22)
  ingress {
    description = "Permitir SSH de qualquer lugar"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Cuidado! Em produção, restrinja isso ao seu IP.
  }

  # Regra de entrada para a porta da API (Porta 3000 para Node.js/Express)
  ingress {
    description = "Permitir acesso a API"
    from_port   = var.api_port
    to_port     = var.api_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Cuidado! Em produção, restrinja isso a IPs específicos.
  }

  # Regra de saída (permitir todo o tráfego de saída)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 significa todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# data "aws_ami" para buscar a AMI mais recente do Ubuntu Server 22.04 LTS (Jammy Jellyfish)
# para a região que você definiu em 'var.aws_region'.
data "aws_ami" "ubuntu_server" {
  most_recent = true
  owners      = ["099720109477"] # ID da conta AWS da Canonical (dona das AMIs Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Recurso: Instância EC2
resource "aws_instance" "api_instance" {
  ami             = data.aws_ami.ubuntu_server.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  associate_public_ip_address = true # Atribuir um IP público
  vpc_security_group_ids = [aws_security_group.api_security_group.id]
  key_name        = aws_key_pair.api_key_pair.key_name

  tags = {
    Name = "${var.project_name}-ec2-instance"
  }
}
