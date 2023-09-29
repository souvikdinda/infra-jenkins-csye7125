# Jenkins Setup with Infrastructure as Code (Terraform) on AWS
---------------------------------------------------------------------------------------------

### Summary
---------------------------------------------------------------------------------------------
- This project is dedicated to automating the setup and teardown of essential AWS infrastructure components required for hosting Jenkins. In addition to provisioning Jenkins, this project also includes automated SSL certificate management using Let's Encrypt with Caddy, ensuring a secure and streamlined Jenkins deployment.



### To run code:
-----------------------

**Prerequisite:** 
Before running the Terraform scripts, ensure the following prerequisites installed:

[AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html), [Terraform ](https://www.terraform.io/)


**Useful Commands**
### Configure AWS Command Line Interface
1. Setup AWS credentials:
    ```
    aws configure
    ```
- his command will prompt you to enter your AWS Access Key ID, AWS Secret Access Key, default region name, and default output format. 

2. Set profile to environment variables:
    -   Linux/Mac
    ```
    export AWS_PROFILE= <profilename>
    ```
    -   Windows
    ```
    setx AWS_PROFILE <profilename>
    ```

**Terraform Commands**
Use the following Terraform commands to deploy and manage your infrastructure:
1. Initialize Terraform:
Run the following command to initialize Terraform in your project directory:
    ```
    Terraform init
    ```
2. Validate Terraform:
To check the syntax of your Terraform configuration files, use:
    ```
   terraform validate 
    ```
3. Plan Terraform:
Generate an execution plan to see what actions Terraform will take:
    ```
    terraform plan

4. Apply Terraform:
Deploy your infrastructure by running:
    ```
    terraform apply
    ```
5. Destroy Terraform:
To tear down your infrastructure, use:
    ```
    terraform destroy
    ```
    

### Infrastructure Setup

The Terraform scripts in this repository set up the following AWS infrastructure components:

- **Virtual Private Cloud (VPC)**:  A logically isolated section of the AWS Cloud where you can launch AWS resources.
- **Subnets**: Public and private subnets for network segregation.
- **Route Tables**: To control the traffic routing between subnets.
- **Internet Gateway**: Provides a target in your VPC route tables for internet-bound traffic.
- **Security Groups**: Defines inbound and outbound traffic rules for your instances.
- **Elastic IP Address Association**: Elastic IP address association for EC2 instance.
- **EC2 Instances**: Virtual servers for running Jenkins.
- **DNS Route53 Record**: DNS record in  Route 53 to associate a custom subdomain  with the Elastic IP address allocated for the Jenkins instance. 
- **Caddy**: A web server used as a reverse proxy for Jenkins.
- **Let's Encrypt**: Automatically managed SSL certificates for securing the Caddy server, ensuring encrypted communications.


_This project is part of CSYE7125 course_