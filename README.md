# **Prerequisites For the Project 

- AWS Account and Installed AWS CLI
- Installed Terraform CLI
- Docker Account 
- Composer

1. Porject Struture 

Main Configuration Files:
- main.tf: Main file that calls various modules.
- variables.tf: Contains all variables used across the configurations.
- ecs.tf: Contains all configurations related to ECS.
- rds.tf: Contains all configurations related to RDS.
- s3.tf: Contains configurations for S3 bucket creation.
- iam.tf: Manages IAM roles and policies.
- alb.tf: Use to provision the Load Balancer
- Vpc.tf: Use to provision network and vpc
  

2. Setup 

a. Clone the Repository 

b. Build the docker image and deploy in your ECR 

c. Initialization
   Setup up your envirnment with terraform , in the terraform folder and run the following : 
`     terraform init
`

d. Deployment
  `terraform plan
   terraform apply`


3. Accessing and Verification 

To access the wordpress from AWS , use the DNS name from the ALB to access your WordPress site.


4. Configure WP Offload Media settings

- Log in to your WordPress admin dashboard using your username and password.
- Configure the plugin settings according to your AWS S3 setup. need to provide AWS access key ID, secret access key, bucket name, and region etc
- Choose the appropriate settings for media offloading, including whether to offload existing media files and whether to serve media files from S3.
- Save and exit
- To verify this , Upload a new media file through the plugin and Check media library to ensure that the file has been offloaded to your AWS S3 bucket
