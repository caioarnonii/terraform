resource "aws_instance" "ec2-terraform1" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  tags = {
    Name = "ec2-terraform1-separado"
  }
}

resource "aws_ebs_volume" "example" {
    availability_zone = "us-east-1a"
    size = 40

    tags = {
        Name = "Hello-terraform"
    }
}

resource "aws_volume_attachment" "ebs_att" {
    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.example
    instance_id = aws_instance.app_server.id
}