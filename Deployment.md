# 🚀 Complete DevOps CI/CD Pipeline

> A production-grade end-to-end DevOps pipeline featuring automated CI/CD, container orchestration, infrastructure as code, and full-stack observability.

---

## 🛠️ Tools & Technologies

<div align="center">

![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![SonarQube](https://img.shields.io/badge/SonarQube-4E9BCD?style=for-the-badge&logo=sonarqube&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Amazon EKS](https://img.shields.io/badge/Amazon%20EKS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![Trivy](https://img.shields.io/badge/Trivy-1904DA?style=for-the-badge&logo=aquasecurity&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![Maven](https://img.shields.io/badge/Apache%20Maven-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)
![Java](https://img.shields.io/badge/Java%2017-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=FF9900)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack-breakdown)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Pipeline Workflow](#-pipeline-workflow)
- [Monitoring](#-monitoring--observability)
- [Domain Configuration](#-domain-configuration)
- [Troubleshooting](#-troubleshooting)
- [Best Practices](#-best-practices)

---

## 🎯 Overview

This project demonstrates a complete end-to-end DevOps implementation featuring:

- **CI/CD Automation** — Jenkins pipeline with multi-stage build, test, scan, and deploy
- **Code Quality** — SonarQube static analysis with quality gate enforcement
- **Artifact Management** — Nexus Repository for Maven artifacts (snapshots & releases)
- **Security Scanning** — Trivy container vulnerability scanning at every build
- **Container Orchestration** — Amazon EKS (Kubernetes) for production workloads
- **Infrastructure as Code** — Terraform for all AWS resource provisioning
- **GitOps** — Declarative deployments via Kubernetes manifests
- **Observability** — Prometheus + Grafana + Blackbox Exporter full monitoring stack
- **Alerting** — Email notifications via Gmail SMTP on build events

---

## 🏗️ Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                        Developer                              │
│                   Git Push → GitHub                          │
└────────────────────────┬─────────────────────────────────────┘
                         │ Webhook
                         ▼
┌──────────────────────────────────────────────────────────────┐
│                  Jenkins CI/CD Pipeline                       │
│                                                              │
│  Git Checkout → SonarQube → Quality Gate → Maven Build       │
│       → Nexus Deploy → Docker Build → Trivy Scan             │
│       → Push to Docker Hub → Deploy to EKS                   │
└────────────────────────┬─────────────────────────────────────┘
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
    ┌───────────┐  ┌───────────┐  ┌───────────┐
    │  SonarQube│  │   Nexus   │  │ Docker Hub│
    │  :9000    │  │  :8200    │  │  Registry │
    └───────────┘  └───────────┘  └───────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────────┐
│              AWS — Amazon EKS (ap-south-1)                   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              rohandevops-cluster                      │   │
│  │  Namespace: webapps                                   │   │
│  │  ┌────────────┐   ┌────────────┐   ┌──────────────┐  │   │
│  │  │ App Pods   │   │  Service   │   │  Prometheus  │  │   │
│  │  │ (Deployment│   │ (LoadBal.) │   │  + Grafana   │  │   │
│  │  └────────────┘   └────────────┘   └──────────────┘  │   │
│  └──────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────┘
```

---

## 🛠️ Tech Stack Breakdown

| Category | Tool | Purpose |
|----------|------|---------|
| CI/CD | Jenkins | Pipeline automation, build orchestration |
| Code Quality | SonarQube | Static analysis, code smell detection |
| Artifacts | Nexus Repository | Maven snapshot & release storage |
| Security | Trivy | Container image vulnerability scanning |
| Containers | Docker | Image build & runtime |
| Orchestration | Kubernetes (EKS) | Production container management |
| IaC | Terraform | AWS resource provisioning |
| Monitoring | Prometheus | Metrics scraping & alerting rules |
| Dashboards | Grafana | Visualization & dashboards |
| Probing | Blackbox Exporter | HTTP endpoint availability monitoring |
| Notifications | Gmail SMTP | Build success/failure email alerts |
| DNS | GoDaddy / Route 53 | Custom domain → ELB CNAME mapping |
| Cloud | AWS (ap-south-1) | EKS, VPC, IAM, Load Balancer |

---

## ✅ Prerequisites

Before starting, generate and securely store the following credentials:

| Credential | Where to Get It |
|-----------|----------------|
| GitHub Personal Access Token | GitHub → Settings → Developer Settings → PAT (Classic) — scopes: `repo`, `workflow`, `admin:repo_hook` |
| SonarQube Token | SonarQube → Administration → Security → Users → Tokens |
| Docker Hub PAT | Docker Hub → Account Settings → Security → New Access Token |
| Google App Password | Google Account → Security → 2-Step Verification → App Passwords |
| AWS Access Key + Secret | AWS Console → IAM → Users → Security credentials |

**System requirements:** Ubuntu 20.04+, 4 GB RAM, 2 vCPUs, 50 GB disk.

---

## 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/rohandeb2/your-repo
cd your-repo

# 2. Provision Jenkins server via Terraform
cd terraform/
terraform init && terraform apply -auto-approve

# 3. Access Jenkins
http://<jenkins-ip>:8080
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# 4. Provision EKS cluster
aws configure
terraform init && terraform apply -auto-approve
aws eks --region ap-south-1 update-kubeconfig --name rohandevops-cluster

# 5. Apply Kubernetes manifests
kubectl create ns webapps
kubectl apply -f k8s/

# 6. Trigger the pipeline
# Push any commit to the main branch — Jenkins webhook fires automatically
```

For the complete step-by-step installation guide, see [DEPLOYMENT.md](./DEPLOYMENT.md).

---

## 🔄 Pipeline Workflow

The Jenkins pipeline runs the following stages on every push to `main`:

```
1. Git Checkout          → Clone latest code from GitHub
2. SonarQube Analysis    → Static code analysis & security hotspots
3. Quality Gate          → Block pipeline if quality gate fails
4. Maven Build           → Compile, test, package the JAR
5. Nexus Deploy          → Publish artifact to Nexus snapshots/releases
6. Docker Build          → Build container image
7. Trivy Scan            → Scan image for CVEs before push
8. Push to Docker Hub    → Tag and push verified image
9. Deploy to EKS         → Rolling update via kubectl apply
10. Email Notification   → Send build result to configured address
```

---

## 📊 Monitoring & Observability

| Component | URL | Purpose |
|-----------|-----|---------|
| Prometheus | `http://<host>:9090` | Metrics collection & alerting rules |
| Grafana | `http://<host>:3000` | Dashboards (admin:admin) |
| Blackbox Exporter | `http://<host>:9115` | HTTP probe / uptime monitoring |

**Recommended Grafana dashboard IDs:**
- `7587` — Blackbox Exporter (endpoint uptime)
- `1860` — Node Exporter Full (system metrics)
- `3119` — Kubernetes Cluster Monitoring

---

## 🌐 Domain Configuration

1. Get the ELB DNS from `kubectl get svc -n webapps`
2. In GoDaddy DNS Management, add/edit a CNAME record:
   - **Type:** CNAME
   - **Name:** www
   - **Value:** `<your-elb>.elb.amazonaws.com` (no `http://`)
   - **TTL:** 600
3. Verify: `nslookup www.rohandevops.co.in`

---

## 🔧 Troubleshooting

| Issue | Fix |
|-------|-----|
| Jenkins won't start | `sudo systemctl status jenkins` → `sudo journalctl -u jenkins -f` |
| Docker permission denied | `sudo chmod 666 /var/run/docker.sock` |
| EKS connection refused | `aws eks update-kubeconfig --region ap-south-1 --name rohandevops-cluster` |
| Prometheus not scraping | Check `http://localhost:9090/targets` and verify Blackbox Exporter: `curl http://localhost:9115/metrics` |
| SonarQube quality gate timeout | Check webhook URL in SonarQube → `http://<jenkins-ip>:8080/sonarqube-webhook/` |

---

## 📝 Best Practices

- Rotate all credentials (Docker, GitHub, AWS, SonarQube) every 90 days
- Enable Kubernetes RBAC — use least-privilege service accounts
- Set Trivy to `--exit-code 1` on CRITICAL CVEs to block bad images
- Keep Jenkins build history to a max of 2 builds to save disk space
- Use Terraform workspaces to separate `dev`, `staging`, and `prod` environments
- Back up Jenkins configuration (`/var/lib/jenkins/`) regularly to S3

---

## 📄 License

This project is licensed under the MIT License.

---

<div align="center">

⭐ **If this project helped you, please give it a star!** ⭐

**Made by [Rohan](https://rohandevops.co.in)**

</div>
