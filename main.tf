module "network" {
  source       = "./modules/network"
  project_name = var.project_name
}

module "security_groups" {
  source       = "./modules/security_group"
  project_name = var.project_name
  vpc_id       = module.network.vpc_id

  security_groups = {
    web_sg = {
      description = "Allow HTTP/HTTPS traffic"
      ingress = [{
        from_port   = 80,
        to_port     = 80,
        protocol    = "tcp",
        cidr_blocks = ["0.0.0.0/0"]
      }],
      egress = [{
        from_port   = 0,
        to_port     = 0,
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
      }]
    }

    ssh_sg = {
      description = "Allow SSH connection"
      ingress = [{
        from_port   = 22,
        to_port     = 22,
        protocol    = "tcp",
        cidr_blocks = ["0.0.0.0/32"]
      }],
      egress = [{
        from_port   = 0,
        to_port     = 0,
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
      }]
    }
  }
}