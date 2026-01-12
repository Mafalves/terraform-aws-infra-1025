resource "aws_instance" "this" {
    for_each = var.instances

    ami           = coalesce(each.value.ami, data.aws_ami.default.id)
    instance_type = each.value.instance_type

    # Select subnet based on instance configuration
    subnet_id = each.value.subnet_type == "public" ? var.public_subnets[each.value.subnet_index] : var.private_subnets[each.value.subnet_index]
    
    vpc_security_group_ids = var.security_groups
    key_name = lookup(each.value, "key_name", null)
    user_data = lookup(each.value, "user_data", null)
    associate_public_ip_address = each.value.subnet_type == "public"
    iam_instance_profile = var.iam_instance_profile
    
    tags = merge({
        Project = var.project_name 
        Name    = "${var.project_name}-${each.key}"
    },
    lookup(each.value, "tags", {}) # if tags are not provided, use an empty map
    )
  }