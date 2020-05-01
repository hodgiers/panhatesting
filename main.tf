provider "aws" {
  #region = var.region
}


module "vpc" {
  source     = "git::https://github.com/hodgiers/terraform-aws-vpc-module"
  cidr_block = var.cidr
  subnets = var.subnets 
  public_rts = var.public_subnets
}

module "firewall-a-pri" {
  source = "git::https://github.com/hodgiers/terraform-aws-panfw-module"
  fw_name = var.fw_ha_a_pri_name 
  fw_key_name = var.fw_key_name
  subnet_id = module.vpc.subnets[var.mgmt_a_subnet].id 
  interfaces = {
    ha = {
      subnet_id = module.vpc.subnets[var.ha_a_subnet].id 
      index = 1
      source_dest_check = false
    }, 
    public = {
      subnet_id = module.vpc.subnets[var.public_a_subnet].id 
      index = 2
      source_dest_check = false
      public_ip = "yes"
    },
    private = {
      subnet_id = module.vpc.subnets[var.private_a_subnet].id 
      index = 3
      source_dest_check = false
    }  
  }
}

module "firewall-a-sec" {
  source = "git::https://github.com/hodgiers/terraform-aws-panfw-module"
  fw_name = var.fw_ha_a_sec_name 
  fw_key_name = var.fw_key_name
  subnet_id = module.vpc.subnets[var.mgmt_a_subnet].id 
  interfaces = {
    ha = {
      subnet_id = module.vpc.subnets[var.ha_a_subnet].id 
      index = 1
      source_dest_check = false
    } 
  }
}

module "firewall-b-pri" {
  source = "git::https://github.com/hodgiers/terraform-aws-panfw-module"
  fw_name = var.fw_ha_b_pri_name 
  fw_key_name = var.fw_key_name
  subnet_id = module.vpc.subnets[var.mgmt_b_subnet].id 
  interfaces = {
    ha = {
      subnet_id = module.vpc.subnets[var.ha_b_subnet].id 
      index = 1
      source_dest_check = false
    }, 
    public = {
      subnet_id = module.vpc.subnets[var.public_b_subnet].id 
      index = 2
      source_dest_check = false
      public_ip = "yes"
    },
    private = {
      subnet_id = module.vpc.subnets[var.private_b_subnet].id 
      index = 3
      source_dest_check = false
    }  
  }
}

module "firewall-b-sec" {
  source = "git::https://github.com/hodgiers/terraform-aws-panfw-module"
  fw_name = var.fw_ha_b_sec_name 
  fw_key_name = var.fw_key_name
  subnet_id = module.vpc.subnets[var.mgmt_b_subnet].id 
  interfaces = {
    ha = {
      subnet_id = module.vpc.subnets[var.ha_b_subnet].id 
      index = 1
      source_dest_check = false
    } 
  }
}    


resource "aws_iam_role" "role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
         "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
"Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": 
        ["ec2:AttachNetworkInterface",
          "ec2:DetachNetworkInterface",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces"
        ],
      "Resource": "*"}
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.role.name
}
