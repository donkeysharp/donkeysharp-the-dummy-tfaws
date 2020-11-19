data "aws_ami" "ecs_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.????????-x86_64-ebs"]
  }
}

data "template_file" "cloud_config" {
  template = file("${path.module}/templates/cloud-init.yml")

  vars = {
    cluster_name = aws_ecs_cluster.cluster.name
  }
}
