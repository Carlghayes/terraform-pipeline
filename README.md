# Automated Ubuntu Deployment Pipeline

A CI/CD pipeline that automatically provisions and hardens an Ubuntu server on AWS using Terraform and cloud-init. A single push to GitHub triggers the entire deployment — no manual steps required.

---

## How it works

1. Code is pushed to the `main` branch on GitHub
2. GitHub Actions triggers automatically
3. Terraform provisions an Ubuntu EC2 instance on AWS with a locked-down security group
4. Cloud-init runs at first boot and hardens the server automatically

---

## What gets configured automatically

- Non-root admin user created with sudo access
- SSH hardened — root login disabled, password authentication disabled, key-based auth only
- UFW firewall configured — inbound traffic restricted to ports 22, 80, and 443
- Automatic security updates enabled via `unattended-upgrades`

---

## Project structure

```
terraform-pipeline/
├── .github/
│   └── workflows/
│       └── deploy.yml        # GitHub Actions pipeline
├── main.tf                   # AWS infrastructure definition
├── variables.tf              # Input variables
├── outputs.tf                # Outputs public IP after deploy
├── cloud-init.yml.tpl        # Server hardening template
├── .gitignore                # Excludes Terraform cache and state files
└── README.md
```

---

## Tools used

| Tool | Purpose |
|---|---|
| Terraform | Provisions AWS infrastructure as code |
| cloud-init | Hardens the server automatically at first boot |
| GitHub Actions | Runs the pipeline on every push to main |
| AWS EC2 | Hosts the Ubuntu server (t2.micro, free tier) |
| UFW | Manages firewall rules on the server |

---

## Prerequisites

- Terraform installed locally
- AWS free tier account with an IAM user that has `AmazonEC2FullAccess`
- AWS CLI configured with `aws configure`
- GitHub account

---

## GitHub Secrets required

Go to your repo → Settings → Secrets and variables → Actions and add:

| Secret | Description |
|---|---|
| `AWS_ACCESS_KEY_ID` | Your IAM user access key |
| `AWS_SECRET_ACCESS_KEY` | Your IAM user secret key |
| `TF_SSH_PUBLIC_KEY` | Your SSH public key (`cat ~/.ssh/terraform-key.pub`) |

---

## Running locally

Initialize Terraform:
```bash
terraform init
```

Preview what will be created:
```bash
terraform plan
```

Deploy:
```bash
terraform apply
```

SSH into the server:
```bash
ssh -i ~/.ssh/terraform-key adminuser@YOUR_PUBLIC_IP
```

Verify firewall:
```bash
sudo ufw status
```

Tear down all resources:
```bash
terraform destroy
```

---

## Security notes

- AWS credentials are stored as GitHub Secrets and never hardcoded in the codebase
- SSH public key is injected at runtime via `templatefile()` — not stored in plain text
- `.gitignore` excludes `terraform.tfstate` and `.terraform/` to prevent sensitive data exposure
- Root login and password authentication are disabled on all deployed servers

---

## Author

Carl Hayes — [github.com/carlghayes](https://github.com/carlghayes)  
PROLUG Linux Admin Course