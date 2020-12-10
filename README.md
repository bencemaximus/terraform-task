# terraform-task

A VPC with internet access

4 subnets:

  2 subnets public.

  2 subnets private with internet access. 

  Make sure access to S3 is not leaving the AWS network.
  

Idea to configure the VPC endpoint:

resource "aws_vpc_endpoint" "private-s3" {
    vpc_id = "${vpc.terraform-vpc.id}"
    service_name = "com.amazonaws.eu-west-1.s3"
    route_table_ids = ["${aws_route_table.default.id}"]
    policy = <<POLICY
{
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY
}
