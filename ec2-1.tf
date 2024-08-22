resource "aws_instance" "ec2-terraform1" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  tags = {
    Name = "ec2-terraform1-separado"
  }
}