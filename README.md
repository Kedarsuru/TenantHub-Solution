# 🚀 TenantHub — Multi-Tenant SaaS Platform (DevOps Assignment)

---

## 📖 Project Overview

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
