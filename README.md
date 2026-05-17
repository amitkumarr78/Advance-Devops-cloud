# Advanced Infrastructure + DevOps End-to-End CI/CD Project
## 📌 Project Overview

This project demonstrates a complete end-to-end DevOps workflow using modern cloud and automation tools. The goal was to build a production-style CI/CD pipeline where code changes automatically move from development to deployment with infrastructure provisioning, containerization, Kubernetes orchestration, and monitoring.
Instead of manually configuring cloud resources and deploying applications, the entire process was automated.

# 🎯 Project Goal

Create a fully automated workflow:

```
Code Change
    ↓
Git Push
    ↓
GitHub Webhook
    ↓
Jenkins Pipeline
    ↓
Docker Build
    ↓
Push Image to ECR
    ↓
Deploy to EKS
    ↓
Kubernetes Rollout
    ↓
Website Updated
    ↓
Prometheus + Grafana Monitoring
```

---

# 🛠 Tech Stack

#### Cloud Platform

* AWS

#### Infrastructure as Code

* Terraform

#### Configuration Management

* Ansible

#### CI/CD

* Jenkins
* GitHub Webhooks

#### Containerization

* Docker
* Amazon ECR

#### Container Orchestration

* Amazon EKS (Kubernetes)

#### Monitoring

* Prometheus
* Grafana

#### Other Tools

* Linux
* Git & GitHub
* AWS CLI
* kubectl

---

# 📂 Project Structure

```
Advance-Devops-cloud/
│
├── terraform/
│   ├── modules/
│   │   ├── EKS/
│   │   ├── backend/
│   │   ├── compute/
│   │   ├── monitoring/
│   │   └── vpc/
│   │
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── variables.tf
│
├── website/
│   └── index.html
│
├── .gitignore
├── Dockerfile
├── Jenkinsfile
└── README.md
```
<img width="405" height="668" alt="Screenshot 2026-05-17 145609" src="https://github.com/user-attachments/assets/11a27010-9011-41ed-9a9f-d5c5d9632674" />


⚠️ Deployment Note
Ansible and Kubernetes configuration files were used directly inside the EC2 deployment environment and were not retained in the final repository structure after successful deployment.
---

# Phase 1: Infrastructure Provisioning with Terraform


Infrastructure was created using Terraform modules instead of manual AWS console setup.

Created resources:

* VPC
* Internet Gateway
* Route Tables
* Security Groups
* Public Subnets
* Private Subnets
* Public EC2 Instance
* Private EC2 Instance
* EKS Cluster
* Node Group

Architecture:

```
VPC
├── Public Subnet 1
├── Public Subnet 2
├── Private Subnet 1
└── Private Subnet 2
```

---

# Phase 2: Terraform Remote Backend

Terraform state management was configured using:

### Amazon S3

Used for storing terraform state files.

### DynamoDB

Used for state locking.

Purpose:

```
Terraform State
        ↓
      S3 Bucket
        ↓
Locking
        ↓
   DynamoDB
```

Benefits:

* Centralized state management
* Prevented concurrent modifications
* Team-friendly setup
<img width="444" height="800" alt="Screenshot 2026-05-16 203531" src="https://github.com/user-attachments/assets/510f5c68-422b-4c61-9463-52c6e6cb81a9" />

---

# Phase 3: Server Configuration with Ansible

Instead of installing software manually, Ansible playbooks automated server setup.

Configured:

* Jenkins installation
* Docker installation
* kubectl installation
* AWS CLI installation

Flow:

```
Infrastructure Created
          ↓
Ansible Playbooks
          ↓
Automatic Server Configuration
```

---

# Phase 4: Application Development

A sample frontend application was created.

Files:

```
website/
    └── index.html
```

---

# Phase 5: Dockerization

The application was containerized using Docker.

Dockerfile:

```dockerfile
FROM nginx:latest
COPY . /usr/share/nginx/html
EXPOSE 80
```

Workflow:

```
Website Code
      ↓
Docker Image
```

---

# Phase 6: Source Control with GitHub

Project repository:

```
GitHub Repository
      ↓
Advance-Devops-cloud
```

GitHub became the central source for application updates.

---

# Phase 7: Jenkins CI/CD Pipeline

Jenkins was installed on the public EC2 instance.

GitHub webhook integration enabled automatic pipeline triggering.

Flow:

```
Git Push
    ↓
Webhook Trigger
    ↓
Jenkins Pipeline
```

Pipeline Stages:

* Checkout code
* Build Docker image
* Tag image
* Push image to ECR
* Deploy to EKS

---
<img width="1920" height="1080" alt="Screenshot 2026-05-16 203502" src="https://github.com/user-attachments/assets/ce3ca98e-2777-49d7-b373-9be43fde4dfd" />

# Phase 8: Amazon ECR Integration

Created ECR repository:

```
website
```

Pipeline:

```
Docker Build
      ↓
Docker Tag
      ↓
Docker Push
      ↓
Amazon ECR
```

---

# Phase 9: Kubernetes Cluster using EKS

Terraform created:

* EKS Cluster
* IAM Roles
* Worker Node Group

Worker node:

```
t3.small
```

Understanding:

EKS manages Kubernetes control plane while worker nodes run workloads.

---

# Phase 10: Kubernetes Deployment

Created:

### deployment.yaml

Responsible for:

* Pod creation
* Replica management
* Container deployment

### service.yaml

Configured:

```yaml
Type: LoadBalancer
```

Flow:

```
User
   ↓
AWS Load Balancer
   ↓
Kubernetes Service
   ↓
Pods
   ↓
Application
```

---

# Phase 11: Dynamic Image Tagging

Initially static image tags caused caching issues.

Old:

```
v1
v2
v3
```

Improved:

```
BUILD_NUMBER
```

Example:

```
website:21
website:22
website:23
```

Benefits:

* Automatic versioning
* No image caching issue
* Easier rollback capability

---

# Phase 12: End-to-End Automated CI/CD Flow

Final implementation:

```
VS Code
   ↓
git push
   ↓
GitHub Webhook
   ↓
Jenkins Trigger
   ↓
Docker Build
   ↓
Push to ECR
   ↓
Update Kubernetes Deployment
   ↓
Automatic Rollout
   ↓
Website Updated
```

No manual deployment commands required.

---

# Phase 13: Monitoring & Observability

Monitoring stack:

### Prometheus

Collected metrics.

### Grafana

Visualized metrics through dashboards.

Flow:

```
Application
      ↓
Metrics
      ↓
Prometheus
      ↓
Grafana Dashboard

Implemented dashboards and observed application metrics visually.
```

<img width="1920" height="1080" alt="Screenshot 2026-05-16 204133" src="https://github.com/user-attachments/assets/4d117932-b202-4338-99c6-2a2ae1cda4e5" />


---

# Final Architecture Diagram

```
                    Users
                      ↓
             AWS Load Balancer
                      ↓
                   EKS Cluster
                      ↓
               Kubernetes Service
                      ↓
                    Pods
                      ↓
               Docker Containers

GitHub
   ↓
Webhook
   ↓
Jenkins
   ↓
Docker Build
   ↓
Amazon ECR
   ↓
EKS Deployment

Prometheus
      ↓
Grafana
```
 <img width="1109" height="621" alt="Screenshot 2026-05-17 143425" src="https://github.com/user-attachments/assets/15b976bd-b4a0-4c74-93e9-3c5db40d7545" />

---

# Validation Checklist

✅ Infrastructure provisioned using Terraform

✅ Remote backend configured using S3 + DynamoDB

✅ Server configuration automated using Ansible

✅ Docker image built successfully

✅ Image pushed to Amazon ECR

✅ EKS cluster provisioned successfully

✅ Kubernetes deployment successful

✅ GitHub webhook triggering Jenkins

✅ End-to-end CI/CD pipeline working

✅ Prometheus monitoring integrated

✅ Grafana dashboards configured

---
## Future Improvements

- Integrate SonarQube for code quality and security analysis
- Implement ArgoCD for GitOps-based continuous deployment
- Add Kubernetes Horizontal Pod Autoscaling (HPA)
- Enhance observability with advanced Grafana dashboards
---

# Conclusion

This project demonstrates practical implementation of DevOps concepts including Infrastructure as Code, Configuration Management, CI/CD, Kubernetes orchestration, cloud deployment, and monitoring in a real-world workflow.
