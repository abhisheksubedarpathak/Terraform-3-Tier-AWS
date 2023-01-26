# Terraform_AWS_Three_Tier_Architecture
<br>
A three-tier architecture typically consists of a presentation tier, application tier, and data tier. Terraform modules can be used to create reusable and repeatable infrastructure-as-code for each tier, and the architecture can be placed within a custom VPC for added security and isolation.

<br><br>
<p align="center" >
  <img src="images/Screenshot 2023-01-26 at 23.01.51.png" width="700px"/>
</p>
<br><br>

This project aims to establish a three-level architecture utilizing Terraform modules to simplify the process of creating repeatable and reusable infrastructure. 
<br><br>
The architecture will be placed within a custom Virtual Private Cloud (VPC) for enhanced security and isolation. 
<br><br>
The web tier will feature a bastion host and NAT gateway in public subnets to provide access to the underlying infrastructure and allow private subnets to access internet updates. 
<br><br>
In the application tier, an internet-facing load balancer will direct internet traffic to an auto-scaling group in private subnets, along with an auto-scaling group for the backend application. The desired capacity for auto-scaling is set up for 2 EC2 instances, with a minimum of 1 and maximum of 2 units. Scripts will be used to install Apache web server on the frontend and Node.js on the backend. 
<br><br>
An additional layer of private subnets in the database tier will host a Multi-zone RDS MySQL database cluster which will be accessed using Node.js. This is just an example of the infrastructure that can be used for a web application. We will be using Cloud9 as Integrated Development Environment (IDE), but other options such as VS Code can also be used.

<br><br>
<p align="center" >
  <img src="images/Screenshot 2023-01-25 at 16.49.29.png" width="700px"/>
</p>
<br><br>

<br><br>
<p align="center" >
  <img src="images/Screenshot 2023-01-25 at 16.50.37.png" width="700px"/>
</p>
<br><br>

