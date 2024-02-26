
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "mykey"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.kp.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
}


resource "aws_instance" "webserver" {
    ami           = "ami-06aa3f7caf3a30282" # Replace with your desired AMI
    instance_type = "t2.micro" # Replace with your desired instance type
    vpc_security_group_ids = [aws_security_group.ssh.id]
    subnet_id = aws_subnet.subnet_a.id
    associate_public_ip_address = "true"
    key_name = aws_key_pair.kp.key_name

    tags = {
        Name = "Web Server for Ankur"
    }
}


output "public_ip" {
    value = aws_instance.webserver.public_ip
}
