output "aws_ami_id" {
  value = module.myapp-server.instance_ami.id
}

output "ec2_public_ip" {
  value = module.myapp-server.instance.public_ip
}