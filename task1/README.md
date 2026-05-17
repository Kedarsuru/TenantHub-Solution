# 🚀 Task 1 — Tenant Provisioning

---

# 📖 Objective

The goal of Task 1 is to automate onboarding of a new tenant (`acme-corp`) into a shared Kubernetes-based SaaS platform.

This task provisions:

- Dedicated PostgreSQL database
- Dedicated PostgreSQL user
- Kubernetes namespace
- RBAC permissions
- GitHub Actions onboarding workflow

The entire flow is designed to be:

- automated
- repeatable
- scalable
- idempotent

---

# 🧠 Problem Statement

In a multi-tenant SaaS platform, manually provisioning infrastructure for every customer is error-prone and difficult to scale.

Problems with manual onboarding:
- inconsistent configurations
- duplicated resources
- human mistakes
- difficult scaling

This task solves that problem using Infrastructure as Code and GitOps workflows.

---

# 🏗️ Architecture Flow

```text
Add tenant in tenants.yaml
            ↓
GitHub Actions triggers
            ↓
Terraform provisions DB + DB user
            ↓
Kubernetes namespace created
            ↓
RBAC permissions applied
            ↓
Tenant environment ready
```

---

# 🔁 Idempotency

This workflow is idempotent.

Terraform maintains infrastructure state and compares desired state with existing resources before applying changes.

If the workflow is executed multiple times for the same tenant:
- Terraform detects that the database and user already exist
- No duplicate infrastructure is created
- Existing resources remain unchanged

Similarly:

```bash
kubectl apply
```

reconciles Kubernetes resources safely without duplicating objects.

This makes the onboarding pipeline:
- safe to retry
- reliable
- production-ready

---

# 🔄 Tenant Onboarding Flow

---

## STEP 1 — Add Tenant

A new tenant is added in:

```yaml
tenants.yaml
```

Example:

```yaml
tenants:
  - name: acme-corp
```

This file acts as the central source of truth for onboarding.

---

## ⚡ STEP 2 — GitHub Actions Trigger

Workflow:

```text
.github/workflows/tenant-onboarding.yaml
```

runs automatically.

The workflow performs:

- initializes Terraform
- runs Terraform apply
- applies Kubernetes manifests
- creates onboarding PR

This fully automates tenant provisioning.

---

## 🏗️ STEP 3 — Terraform Infrastructure Provisioning

Terraform provisions:

### PostgreSQL Database

Example:

```text
acme_corp_db
```

### PostgreSQL User

Example:

```text
acme_corp_user
```

### Random Secure Password

Generated automatically using Terraform.

This ensures:
- tenant-level database isolation
- separate credentials per tenant

---

## ☸️ STEP 4 — Kubernetes Namespace Creation

Namespace:

```text
acme-corp
```

is created.

Purpose:
- logical tenant isolation
- separate workload boundary

Each tenant gets its own Kubernetes environment.

---

## 🔐 STEP 5 — RBAC Configuration

The following Kubernetes RBAC resources are created:

### ServiceAccount

Acts as identity for tenant workloads.

---

### Role

Provides:
- read-only access to secrets
- namespace-scoped permissions

---

### RoleBinding

Connects:
- ServiceAccount
to
- Role permissions

This follows:

> Least Privilege Principle

---

# ▶️ How to Run

---

## Terraform Init

```bash
cd terraform
terraform init
```

What happens:
- Terraform downloads required providers
- initializes working directory

---

## Terraform Plan

```bash
terraform plan
```

What happens:
- shows infrastructure changes before apply
- previews database + user creation

---

## Terraform Apply

```bash
terraform apply
```

What happens:
- database created
- database user created
- passwords generated

---

## Apply Kubernetes Resources

```bash
kubectl apply -f kubernetes/acme-corp/
```

What happens:
- namespace created
- service account created
- RBAC resources applied

---

# 🔁 Idempotency Behavior

If the workflow runs again for the same tenant:

Terraform:
- detects existing infrastructure
- performs no duplicate creation

Kubernetes:
- reconciles desired state
- safely reapplies manifests

Result:
- no duplicated databases
- no duplicate namespaces
- no configuration drift

This makes the platform:
- resilient
- retry-safe
- automation-friendly

---

# 📈 Scalability

The onboarding system scales to 50+ tenants using:

- reusable Terraform modules
- `for_each` iteration
- declarative Kubernetes manifests
- centralized tenant definitions

Adding a new tenant only requires:

```yaml
tenants:
  - name: new-tenant
```

No workflow logic changes are required.

---

# ✅ Final Outcome

After onboarding:

Each tenant receives:
- isolated PostgreSQL database
- dedicated database user
- Kubernetes namespace
- scoped RBAC permissions
- automated onboarding workflow

This creates a scalable and production-ready multi-tenant SaaS onboarding platform.
