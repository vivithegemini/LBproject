The goal of this code is to be able to build an application load balancer in the AWS cloud using Terraform.
the followings were created:
- a target group
- a listener for the load balancer
- a load balancer
- a vpc
- a subnet
- two security groups for the application load balancer and ec2 instances
- a route table, an internet gateway and an internet route

After successful creation of the load balancer in AWS EC2 using terraform, you can check the load balancer DNS on the browser. Then you will be able to see how the load balancer is sharing the traffic 
