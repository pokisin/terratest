resource "aws_instance" "ec2instance" {
    ami = var.ec2ami
    instance_type = var.ec2type
    network_interface {
        network_interface_id = var.ec2iface
        device_index     = 0
    }
    tags = {
        Name = var.ec2name
    }
}