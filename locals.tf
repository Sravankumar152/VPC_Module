locals {
  
    commontags={
        Name = var.project
        Environment = var.environment
        Terraform = "true"
    }

    vpc_tags = merge(
        local.commontags,
        {
            Name ="${var.project}-${var.environment}"
        }
    )

    ig_final_tags=merge(
        local.commontags,
        {
            Name ="${var.project}-${var.environment}"
        },
        var.tags
    )

}
