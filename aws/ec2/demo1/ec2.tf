resource "aws_instance" "my_tf_instance" {
  ami = "ami-024f768332f080c5e" #eu-central-1
  instance_type          = "t2.micro"
  key_name               = "tf_key"
  monitoring             = true
  vpc_security_group_ids = ["sg-059779cb2707b79c0"]
  subnet_id              = "subnet-055ddb6a4ead1892f"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_key_pair" "tf_key" {
    key_name = "tf_key"
    public_key = tls_private_key.rsa.public_key_openssh   
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "tf_key_file" {
    content = tls_private_key.rsa.private_key_pem
    filename = "tf_key_file.p8"
}