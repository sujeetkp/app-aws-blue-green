resource "null_resource" "configure_bastion" {
  depends_on = [
    module.ec2_public
  ]

  connection {
    host = aws_eip.bastion_eip.public_ip
    type = "ssh"
    user = "ec2-user"
    private_key = file("private-key/us-east-1-kp.pem")
  }

  provisioner "file" {
    source = "private-key/us-east-1-kp.pem"
    destination = "/tmp/us-east-1-kp.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/us-east-1-kp.pem"
    ]
  }
}