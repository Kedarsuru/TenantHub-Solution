# 🚀 TenantHub — Multi-Tenant SaaS Platform (DevOps Assignment)


## 📖 Project Overview



---

# 🗂️ Repository Structure

```text
📦 TenantHub-Repo
├── ⚙️ .github
│   └── 🔄 workflows
│       ├── 📜 pr-diff.yaml
│       └── 📜 tenant-onboarding.yaml
│
├── ☸️ Task2
│   ├── ☸️ kubernetes
│   │   └── 🏢 acme-corp
│   │       ├── 🔐 externalsecret.yaml
│   │       ├── 🌐 networkpolicy.yaml
│   │       └── 👤 serviceaccount-patch.yaml
│   │
│   ├── 🌱 terraform
│   │   └── 🔑 secret-manager.tf
│   │
│   └── 📘 README.md
│
├── 🚀 Task3
│   ├── 🔁 argocd
│   │   ├── 🔄 workflows
│   │   │   └── 📜 pr-diff.yaml
│   │   │
│   │   └── 📢 argocd-notifications-cm.yaml
│   │
│   ├── 📘 README.md
│   └── 📄 kustomizeoutput.txt
│
├── 🏗️ task1
│   ├── ☸️ kubernetes
│   │   └── 🏢 acme-corp
│   │       ├── 📦 namespace.yaml
│   │       ├── 🔒 role.yaml
│   │       ├── 👥 rolebinding.yaml
│   │       └── 👤 serviceaccount.yaml
│   │
│   ├── 🌱 terraform
│   │   └── 🧩 modules
│   │       └── 🗄️ tenant-db
│   │           ├── ⚙️ main.tf
│   │           ├── 📤 outputs.tf
│   │           ├── 🔌 providers.tf
│   │           ├── 📝 terraform.tfvars
│   │           └── 📥 variables.tf
│   │
│   └── 📘 README.md
│
└── 📘 README.md
```

---

# 📖 Overview

This repository contains a complete **DevOps / Platform Engineering solution** for a **multi-tenant SaaS platform** running on a shared Kubernetes (GKE) cluster.

Each tenant (e.g. `acme-corp`) is provisioned with:

- 🗄️ Dedicated PostgreSQL database inside a shared Cloud SQL instance
- 👤 Dedicated database user
- ☸️ Isolated Kubernetes namespace
- 🔒 RBAC-based access control
- 🔑 Per-tenant secrets in GCP Secret Manager
- 🪪 Workload Identity-based authentication
- 🌐 Network-level isolation using Kubernetes NetworkPolicies

The platform is fully automated using:

- 🌱 Terraform (Infrastructure as Code)
- ☸️ Kubernetes manifests
- 🔄 GitHub Actions (CI/CD Automation)
- 🚀 ArgoCD Notifications (GitOps Observability)
- 🧩 Kustomize (Manifest Rendering & Diffing)

---

# 🏛️ Architecture Summary

The platform follows a **multi-layer tenant isolation model**:

| Layer | Technology |
|---|---|
| 🪪 Identity Layer | Workload Identity + GCP Service Accounts |
| 🔑 Secrets Layer | GCP Secret Manager |
| ☸️ Compute Layer | Kubernetes Namespaces |
| 🌐 Network Layer | Kubernetes NetworkPolicies |
| 🌱 Infrastructure Layer | Terraform-managed Cloud SQL |

---

# 🏗️ Task 1 — Tenant Provisioning

Automates onboarding of new tenants.

### ✅ Features

- 🗄️ Creates PostgreSQL database + user
- ☸️ Creates isolated Kubernetes namespace
- 🔒 Configures RBAC permissions
- 🔄 GitHub Actions-driven provisioning
- 🌱 Terraform state-based idempotency

### 🔁 Key Property: Idempotency

If provisioning runs multiple times:

- ✅ Terraform detects existing resources
- ✅ Kubernetes reconciles desired state
- ✅ No duplicate resources are created

---

# 🔐 Task 2 — Secret Isolation & Security

Implements strong tenant-level security controls.

### ✅ Features

- 🔑 Dedicated Secret Manager secret per tenant
- 🪪 Workload Identity authentication
- 🔒 Least-privilege IAM permissions
- ☸️ External Secrets Operator integration
- 🌐 Restricted egress using NetworkPolicies

### 🛡️ Security Model

This prevents:

- ❌ Cross-tenant secret access
- ❌ Unauthorized database connectivity
- ❌ Broad IAM permissions
- ❌ Shared namespace risks

---

# 🚀 Task 3 — Infrastructure Change Visibility

Improves deployment safety and GitOps observability.

## 🔍 PR Diff Workflow

- 🧩 Runs `kustomize build`
- 🔄 Compares manifests between PR and main branch
- 💬 Posts rendered diff directly in Pull Requests

## 📢 ArgoCD Notifications

Sends Slack alerts when applications become:

- ⚠️ Degraded
- 🔄 OutOfSync

Includes:

- 📦 Application Name
- 🌍 Environment
- 🔗 ArgoCD Dashboard Link

---

# 📈 Scalability

Designed to scale for **50+ tenants**.

### ⚡ Scalability Features

- 🌱 Terraform `for_each`
- 📄 Centralized `tenants.yaml`
- 🧩 Reusable modules
- ☸️ Declarative Kubernetes manifests
- 🔄 Reusable GitHub workflows

---

# 🧠 Key Design Principles

- 🌱 Infrastructure as Code
- 🔄 GitOps Automation
- 🔒 Least Privilege Security
- ☸️ Strong Tenant Isolation
- ♻️ Fully Idempotent Pipelines
- 📊 Production-grade Observability

---

# 🚧 Production Enhancements

In a real production SaaS platform, this can be extended with:

- ☁️ Remote Terraform Backend (GCS + Locking)
- 🔄 Secret Rotation Policies
- 🌍 Multi-environment Deployments
- 🛡️ Policy-as-Code (OPA / Kyverno)
- 📊 Centralized Logging & Audit Trails
- 🚨 Advanced Monitoring & Alerting

---

This repository contains a complete DevOps / Platform Engineering solution for a multi-tenant SaaS platform running on a shared Kubernetes (GKE) cluster.

The system automates:

- Tenant onboarding
- Database provisioning
- Kubernetes isolation
- Secret management
- Network isolation
- Infrastructure visibility
- Deployment monitoring

Each tenant (example: `acme-corp`) gets fully isolated infrastructure inside a shared platform.

---

## 🧠 What is a Tenant?

A tenant is a customer organization using the SaaS platform.

Examples:
- acme-corp
- walmart
- infosys

Each tenant gets:
- own database
- own Kubernetes namespace
- own secrets
- isolated permissions

This is called Multi-Tenant SaaS Architecture.

---

## ⚙️ Technologies Used

- Terraform → Infrastructure provisioning
- Kubernetes → Workload isolation
- GitHub Actions → CI/CD automation
- GCP Secret Manager → Secret storage
- Workload Identity → Secure authentication
- External Secrets Operator → Secret syncing
- Kustomize → Manifest rendering
- ArgoCD → Deployment monitoring

---

## 🏗️ Repository Structure

(Refer folder structure in repo)

---

# 🔄 COMPLETE END-TO-END FLOW

## 👉 STEP 1: Add a New Tenant

A developer adds a tenant in:

```yaml
tenants.yaml
```

Example:

```yaml
tenants:
  - name: acme-corp
```

This file is the source of truth.



## ⚡ STEP 2: GitHub Actions Trigger


Workflow:

.github/workflows/tenant-onboarding.yaml

Automatically runs when tenants.yaml is updated.

It:

reads tenant list
triggers Terraform
applies Kubernetes manifests

## 🏗️ STEP 3: Terraform Provisioning

Terraform creates:

PostgreSQL database (acme_corp_db)
PostgreSQL user (acme_corp_user)
secure password
Idempotency:

If run again:

existing resources are reused
no duplicates are created

## ☸️ STEP 4: Kubernetes Isolation

For each tenant:

Namespace → acme-corp
ServiceAccount → tenant identity
Role → restricted permissions
RoleBinding → connects permissions

This ensures tenant isolation inside cluster.


## 🔐 STEP 5: Secret Isolation

Each tenant gets a dedicated secret:

tenant-acme-corp-credentials

Stored in:
GCP Secret Manager

This prevents cross-tenant data access.


## 🔗 STEP 6: Workload Identity

Flow:

Kubernetes ServiceAccount → Google Service Account → GCP Secret Manager

No static credentials are used.


## 🔒 STEP 7: IAM Scoped Access

Each tenant has access ONLY to its own secret:

roles/secretmanager.secretAccessor

Scoped per secret (not project-wide).


## 🔄 STEP 8: External Secrets Operator

Syncs:

GCP Secret Manager → Kubernetes Secret

Applications use normal Kubernetes secrets.


## 🌐 STEP 9: Network Isolation

NetworkPolicy allows ONLY:

DNS access
tenant database access

Blocks:

other namespaces
internet access
cross-tenant traffic


## 🔍 STEP 10: PR Diff Workflow

Runs on every PR:

.github/workflows/pr-diff.yaml

It:

builds Kubernetes manifests from main branch
builds from PR branch
compares outputs using kustomize

This shows exact infrastructure changes before merge.



## 📡 STEP 11: ArgoCD Monitoring

ArgoCD sends Slack alerts when:

Application becomes Degraded
Application becomes OutOfSync

Includes:

app name
environment
dashboard link

▶️ HOW TO RUN THE PROJECT


1. Terraform Init
```yaml
cd task1/terraform
terraform init
```
2. Terraform Plan
```yaml
terraform plan
```

Shows resources to be created.

3. Terraform Apply
```yaml
terraform apply
```

Creates:

database
user
secrets

4. Apply Kubernetes

```yaml
kubectl apply -f task1/kubernetes/acme-corp/
```
Creates:

namespace
RBAC
service account
5. Generate Kustomize Output
kustomize build .

Produces final Kubernetes YAML.

🔁 IDEMPOTENCY

System is safe to re-run:

Terraform detects existing resources
Kubernetes is declarative
No duplication occurs


🧱 SECURITY MODEL (DEFENSE IN DEPTH)
Layer	Protection
Namespace	workload isolation
RBAC	permission control
Secret Manager	secret isolation
IAM	identity control
Workload Identity	secure authentication
NetworkPolicy	traffic isolation

📈 SCALABILITY

Supports 50+ tenants easily.

To add a tenant:

only update tenants.yaml

No code changes required.

🛠️ DESIGN PRINCIPLES
Infrastructure as Code
GitOps workflow
Least privilege security
Fully automated provisioning
Declarative infrastructure
Scalable multi-tenancy
