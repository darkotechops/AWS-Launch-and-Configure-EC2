# Cloud-First
## This lab covers the following topics:
  - Launch an Amazon EC2 Instance
  - Configure a user data script to display the instance details in a browser
  - Launch a second Amazon EC2 Instance in a different Availability Zone of the same AWS Region.
---
- An Amazon Elastic Compute Cloud ( Amazon EC2 ) instance s a virtual server in the cloud
- An Amazon Machine Image ( AMI ) provides the information required to launch an instance. We must specify an AMI when launching an instance. We can launch multiple instances from a single AMI when we need multiple instances with same configuration. Also we can use different AMIs to launch instances when we need different configuration.
- A virtual private cloud ( VPC ) is a virtual network dedicated to AWS account. While a VPC resides in an AWS Region, a subnet must reside within a single AZ.
- Security Group acts as a virtual firewall that controls the raffic for one or more instances. When we launch an instance, we can specify one or more security groups, otherwise the default security group is used.
  We can add rules to each security group that allows traffic to or from it's associated instances.

## Project steps and diagram on AWS
- Check lab folder which contains diagram and steps to execute lab on AWS
