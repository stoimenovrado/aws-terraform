provider "aws" {
  access_key = var.v-access-key
  secret_key = var.v-secret-key
  region     = var.region
}

resource "aws_instance" "db" {
    ami = var.v-ami-image
    instance_type = var.v-instance-type
    key_name = var.v-instance-key
    vpc_security_group_ids = [var.v_vsgi]
    subnet_id              = var.v_si
    private_ip   = "10.10.10.117"
    tags = {
        Name = "db"
    }
    provisioner "file" {
        source      = "./db/provision-db.sh"
        destination = "/tmp/provision-db.sh"
        connection {
            type = "ssh"
            user = "ubuntu"
            private_key = file("c:\\keys\\terraform-key2.pem")
            host = self.public_ip
        }
    }
    provisioner "remote-exec" {
        inline = [
        "chmod +x /tmp/provision-db.sh",
        "/tmp/provision-db.sh"
        ]
        connection {
            type = "ssh"
            user = "ubuntu"
            private_key = file("c:\\keys\\terraform-key2.pem")
            host = self.public_ip
        }
    }
}
