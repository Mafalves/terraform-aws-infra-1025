# -----------------------------
# NETWORK MODULE
# -----------------------------
module "network" {
  source       = "./modules/network"
  project_name = var.project_name
}

# -----------------------------
# SECURITY GROUPS MODULE
# -----------------------------
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

# -----------------------------
# COMPUTE MODULE
# -----------------------------
module "compute" {
  source = "./modules/compute"

  project_name    = var.project_name
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets_id
  public_subnets  = module.network.private_subnets_id
  security_groups  = values(module.security_groups.security_group_id)

  instances = {
    web_01 = {
      instance_type = "t3.micro"
      subnet_type   = "public"
      subnet_index  = 0
    }

    app_01 = {
      instance_type = "t3.micro"
      subnet_type   = "private"
      subnet_index  = 0
    }
  }
}