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

## Idempotency

This workflow is idempotent.

Terraform maintains infrastructure state and compares desired state
with existing resources before applying changes.

If the workflow is executed multiple times for the same tenant,
Terraform detects that the database and user already exist and
performs no additional changes.

Similarly, `kubectl apply` reconciles Kubernetes resources safely
without duplicating objects.

This makes the onboarding pipeline safe to retry.

---

## Scaling to 50+ Tenants

The solution scales using:

- reusable Terraform modules
- `for_each` iteration
- declarative Kubernetes manifests

Adding a new tenant only requires updating `tenants.yaml`.

No workflow logic changes are required.
