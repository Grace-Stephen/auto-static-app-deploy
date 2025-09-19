Automated Deployment of a Secure, High-Availability Dockerized Static Website

Overview

This project demonstrates the end-to-end automation of deploying a static website hosted in a Docker container on AWS EC2, using Terraform and GitHub Actions. While a static site could be served more simply via S3 + CloudFront, this build deliberately implements secure, high-availability infrastructure to simulate real-world production-grade architecture.

The entire deployment—from provisioning infrastructure to running the containerized application—is fully automated. The CI/CD pipeline provisions AWS resources, builds and pushes a Docker image to Amazon ECR, and launches an EC2 instance in a private subnet, accessible only through an Application Load Balancer (ALB) with HTTPS termination via AWS Certificate Manager (ACM).

Architecture

This setup follows a two-tier architecture:

Tier 1 (Public): Application Load Balancer, Route 53 DNS, ACM (SSL/TLS certificates)

Tier 2 (Private): EC2 instances hosting the Dockerized application

Key security consideration:
The EC2 instance running the application is not directly exposed to the internet. The ALB acts as a reverse proxy, terminating SSL, forwarding traffic securely, and shielding the private IP of the server.

AWS Services Used: 

VPC – Custom VPC with public and private subnets

EC2 – Hosts Dockerized static site in a private subnet

ECR – Stores Docker image for deployment

Route 53 – DNS hosting, connected to registered domain

ACM – SSL certificate management for HTTPS access

Application Load Balancer (ALB) – Public access point with reverse proxy and SSL termination

IAM – Roles and permissions for EC2 and ECR

S3 – Backend for Terraform state storage

CI/CD Workflow

GitHub Actions is used to automate:

1. Infrastructure Provisioning
- Terraform initializes, plans, and applies AWS resources.

2. Image Build & Deployment
- Docker image is built and pushed to Amazon ECR.

3. Application Launch
- EC2 instance user_data installs Docker, pulls the image from ECR, and runs the container.

The pipeline uses a private GitHub Actions runner, ensuring that builds run in a controlled, secure environment.


Domain & SSL Setup
- Domain registered in Namecheap
- Hosted zone created in Route 53
- ALB DNS name mapped to domain via Route 53 alias record
- ACM issues and validates SSL/TLS certificate via Route 53 DNS validation
- All HTTP traffic redirected to HTTPS

Learning Outcomes

Through this project, I gained deeper practical understanding of:

- Secure AWS networking (public/private subnets, ALB as reverse proxy)

- Terraform:
. Root vs child modules and proper file structuring
. Outputs, variables, and Terraform state management with S3 backend
. Dependencies and workflow ordering in CI/CD pipelines

- CI/CD best practices with GitHub Actions and private runners

- Docker in AWS workflows (using .dockerignore, pushing to ECR)

- Domain and certificate automation using Route 53 + ACM

- High availability concepts applied to a simple application


Why This Architecture for a Static Website?

While simpler hosting options exist, the aim was not to optimize cost but to:

- Simulate production-ready AWS deployment patterns

- Practice security best practices

- Understand end-to-end automation 


Tech Stack
- Infrastructure as Code: Terraform

- Containerization: Docker

- CI/CD: GitHub Actions (private runner)

- Cloud Provider: AWS (EC2, ECR, ALB, Route 53, ACM, VPC, IAM, S3)

- IDE: VSCode

- Domain Registrar: Namecheap

Deployment Flow

1. Push code to GitHub → triggers GitHub Actions workflow.

2. Terraform provisions AWS infrastructure.

3. Docker image is built and pushed to ECR.

4. EC2 instance pulls and runs the image automatically.

5. Application accessible via HTTPS through ALB DNS or custom domain.
