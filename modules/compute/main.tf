locals {
    subnet_map = {
        for name, instance in var.instances : name => (
            instance.subnet_type == "public"
            ? var.public_subnets[instance.subnet_index]
            : var.private_subnets[instance.subnet_index]
        )
    }
}

resource "aws_instance" "this" {
    for_each = var.instances

    ami = coalesce(each.value.ami, data.aws_ami.default.id) # Use provided AMI or default
    instance_type = each.value.instance_type
    subnet_id = local.subnet_map[each.key]
    vpc_security_group_ids = var.security_groups
    key_name = lookup(each.value, "key_name", null)
    user_data = lookup(each.value, "user_data", null)
    associate_public_ip_address = each.value.subnet_type == "public"

    tags = {
        Project = var.project_name 
        Name    = "${var.project_name}-${each.key}"
    } 
  }