### Overview
This document outlines the design rationale behind the chosen cloud platform (AWS), infrastructure components (EC2, Apache, security group), and how the CI/CD pipeline is structured to support both simulated and real deployment scenarios using GitHub Actions.

## Design Rationale

**Cloud Platform**: AWS was selected for its widespread use, flexibility, and free-tier EC2 options.

**IaC Tool**: Terraform was chosen due to its popularity, declarative syntax, and multi-cloud support.

**Components Defined**:
- One EC2 instance using Amazon Linux 2
- Security group allowing inbound HTTP traffic
- `user_data.sh.tpl` template used to serve a static page from `index.html`

**CI/CD**: GitHub Actions was selected for its native integration with GitHub repos and ease of use.

## CI/CD Process
The pipeline simulates the following steps:
- Checkout the code
- Initialize Terraform
- Apply infrastructure changes
- Print success message (no real deployment run)