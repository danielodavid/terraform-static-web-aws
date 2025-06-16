# terraform-static-web-aws
## Overview
This project demonstrates how to use **Terraform** (Infrastructure as Code) to provision infrastructure on **AWS**. It defines an EC2 instance that would serve a static HTML page via Apache, simulating what a basic production workload might look like.

### Chosen Stack
- **Cloud Platform:** AWS (Amazon Web Services)
- **IaC Tool:** Terraform (v1.7+)
- **CI/CD Tool:** GitHub Actions

### Resource Summary
- **EC2 instance**: Runs Amazon Linux 2 (or equivalent)
- **Security Group**: Allows HTTP traffic on port 80
- **Apache Web Server**: Serves a custom `index.html`
- **User data script**: Automatically installs and configures the server on boot

### Deployment Commands
To deploy this infrastructure manually, the following Terraform commands *would* be used:
bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve

These are echoed in the GitHub Actions pipeline for simulated CI/CD flow, and optionally executed if AWS credentials are configured.

### Files
- `main.tf`: Terraform code to create an EC2 instance and security group
- `user_data.sh.tpl`: Template script to install Apache and serve a custom `index.html` page
- `index.html`: Static web page content
- `.github/workflows/deploy.yml`: Placeholder GitHub Actions workflow
- `README.md`: Project explanation
- `design.md`: Design rationale and deployment details

### CI/CD Workflow Behavior
This project includes a GitHub Actions workflow located in `.github/workflows/deploy.yml`. It supports two modes:

#### Simulated Mode (Default)
If no AWS credentials are configured in the repo:
- `terraform init`, `plan`, and `apply` are **simulated** using `echo` commands
- This mode is safe for tasks and demo purposes

#### Real Mode (With AWS Secrets)
If you define the following **GitHub Secrets**:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

Then:
- A real `terraform init` and `terraform plan` will run
- If you also set `TF_AUTO_APPLY=true`, it will execute `terraform apply`

This enables you to use the same workflow for both CI/CD simulation and production-level provisioning.

### Local Testing (Optional)
To simulate the EC2 environment locally without using AWS, run:

bash
vagrant up

Then open your browser at:
http://localhost:8080

This starts a local Amazon Linux 2 VM, installs Apache, and serves the `index.html` file just like the AWS EC2 instance would.

### Local Testing Options
If you're using an Apple Silicon (M1/M2) Mac or prefer a lighter setup, Docker is a great alternative to Vagrant:

#### Docker
1. Create a `Dockerfile` in your project root:
Dockerfile
FROM httpd:2.4
COPY index.html /usr/local/apache2/htdocs/index.html

2. Build the image:
bash
docker build -t terraform-apache-test .

3. Run the container:
bash
docker run -d -p 8080:80 --name tf-test terraform-apache-test

4. Visit `http://localhost:8080` in your browser

This emulates the behavior of your EC2 instance using local resources only.