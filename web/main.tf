provider "aws" {
  access_key = var.v-access-key
  secret_key = var.v-secret-key
  region     = var.region
}

resource "aws_instance" "web" {
    ami = var.v-ami-image
    instance_type = var.v-instance-type
    key_name = var.v-instance-key
    vpc_security_group_ids = [var.v_vsgi]
    subnet_id              = var.v_si
    private_ip   = "10.10.10.118"
    tags = {
        Name = "web"
    }
    provisioner "file" {
        source      = "./web/provision-web.sh"
        destination = "/tmp/provision-web.sh"
        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = file("c:\\keys\\terraform-key2.pem")
            host = self.public_ip
        }
    }
    provisioner "remote-exec" {
        inline = [
        "chmod +x /tmp/provision-web.sh",
        "/tmp/provision-web.sh"
        ]
        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = file("c:\\keys\\terraform-key2.pem")
            host = self.public_ip
        }
    }
}
