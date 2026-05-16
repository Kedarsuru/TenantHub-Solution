

# TenantHub — Multi-Tenant SaaS Platform (DevOps Assignment)


## Overview

.
├── .github
│   └── workflows
│       ├── pr-diff.yaml
│       └── tenant-onboarding.yaml
├── Task2
│   ├── kubernetes
│   │   └── acme-corp
│   │       ├── externalsecret.yaml
│   │       ├── networkpolicy.yaml
│   │       └── serviceaccount-patch.yaml
│   ├── terraform
│   │   └── secret-manager.tf
│   └── README.md
├── Task3
│   ├── argocd
│   │   ├── workflows
│   │   │   └── pr-diff.yaml
│   │   └── argocd-notifications-cm.yaml
│   ├── README.md
│   └── kustomizeoutput.txt
├── task1
│   ├── kubernetes
│   │   └── acme-corp
│   │       ├── namespace.yaml
│   │       ├── role.yaml
│   │       ├── rolebinding.yaml
│   │       └── serviceaccount.yaml
│   ├── terraform
│   │   ├── modules
│   │   │   └── tenant-db
│   │   │       ├── main.tf
│   │   │       ├── outputs.tf
│   │   │       ├── providers.tf
│   │   │       ├── terraform.tfvars
│   │   │       └── variables.tf
│   └── README.md


This repository contains a complete DevOps/Platform Engineering solution for a multi-tenant SaaS system running on a shared Kubernetes (GKE) cluster.

Each tenant (e.g., `acme-corp`) is provisioned with:

- Dedicated PostgreSQL database inside a shared Cloud SQL instance
- Dedicated database user
- Isolated Kubernetes namespace
- RBAC-based access control
- Per-tenant secrets in GCP Secret Manager
- Workload Identity-based authentication
- Network-level isolation using Kubernetes NetworkPolicies

The system is fully automated using:
- Terraform (Infrastructure as Code)
- Kubernetes manifests (declarative configuration)
- GitHub Actions (CI/CD automation)
- ArgoCD notifications (GitOps observability)
- Kustomize (manifest rendering & diffing)

---

## Architecture Summary

The platform is designed around **multi-layer isolation**:

- **Identity Layer** → Workload Identity + GCP Service Accounts
- **Secrets Layer** → Secret Manager (per-tenant secrets)
- **Compute Layer** → Kubernetes namespaces per tenant
- **Network Layer** → NetworkPolicies for egress control
- **Infrastructure Layer** → Terraform-managed Cloud SQL resources



---

## Task 1 — Tenant Provisioning

Automates onboarding of a new tenant:

- Creates PostgreSQL database + user via Terraform module
- Creates Kubernetes namespace (`acme-corp`)
- Configures RBAC for namespace-scoped secret access
- Uses GitHub Actions to trigger provisioning from `tenants.yaml`
- Ensures idempotent execution using Terraform state

### Key Property: Idempotency
If the workflow runs multiple times for the same tenant:
- Terraform detects existing resources
- Kubernetes `apply` reconciles desired state
- No duplicate resources are created

---

## Task 2 — Secret Isolation & Security

Implements strong multi-tenant security:

- Each tenant has a dedicated Secret Manager secret
- Workload Identity binds Kubernetes ServiceAccount → GCP Service Account
- IAM is scoped to a single secret (not project-wide access)
- External Secrets Operator syncs secrets into Kubernetes
- NetworkPolicy restricts egress to:
  - DNS only
  - Tenant-specific database

### Security Model

This ensures **least privilege access** and prevents cross-tenant data leakage even in a shared cluster environment.

---

## Task 3 — Infrastructure Change Visibility

Improves deployment safety and observability:

### PR Diff Workflow
- Runs `kustomize build` on both `main` and PR branch
- Compares rendered Kubernetes manifests
- Posts diff as PR comment for review visibility

### ArgoCD Notifications
- Sends Slack alerts when application state becomes:
  - `Degraded`
  - `OutOfSync`
- Includes application name, environment, and ArgoCD UI link

---

## Scalability

The system is designed to scale to **50+ tenants** by:

- Using Terraform `for_each` for tenant modules
- Keeping tenant definitions in `tenants.yaml`
- Avoiding hardcoded workflows per tenant
- Using reusable Kubernetes manifests

---

## Key Design Principles

- Infrastructure as Code (Terraform)
- GitOps-driven deployments (ArgoCD + GitHub Actions)
- Least privilege security model
- Strong tenant isolation
- Fully idempotent automation pipelines
- Production-grade observability

---

## How to Extend to Production

In a real SaaS environment, this system would be extended with:

- Remote Terraform state backend (GCS + locking)
- Vault or Secret Manager rotation policies
- Multi-environment support (dev/staging/prod)
- Policy-as-code (OPA / Kyverno)
- Centralized logging and audit trails
---


