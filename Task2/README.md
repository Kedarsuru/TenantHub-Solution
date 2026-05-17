
---

# 📄 `Task2`

```md id="qpr6jl"
# 🔐 Task 2 — Secret Isolation & Security

---

# 📖 Objective

The goal of Task 2 is to improve tenant security and isolation in a shared Kubernetes cluster.

Previously:
- all tenants shared one Kubernetes Secret
- any compromised pod could potentially access all tenant credentials

This task introduces:
- per-tenant secrets
- Workload Identity
- scoped IAM permissions
- External Secrets Operator
- NetworkPolicies

The design follows:

> Least Privilege + Defense in Depth

---

# 🧠 Problem Statement

In a shared SaaS cluster:
- tenants must not access each other’s credentials
- workloads must not communicate freely
- cloud access must be tightly scoped

Without proper isolation:
- cross-tenant data leakage becomes possible
- compromised workloads can move laterally

---

# 🏗️ Security Architecture Flow

```text
Tenant Secret Stored in GCP Secret Manager
                    ↓
Google Service Account created
                    ↓
IAM access scoped to single secret
                    ↓
Kubernetes ServiceAccount mapped using Workload Identity
                    ↓
External Secrets Operator syncs secret into namespace
                    ↓
NetworkPolicy restricts tenant traffic

```


## 🔐 STEP 1 — Per-Tenant Secret Creation

Each tenant receives a dedicated secret in:

GCP Secret Manager

Example:

tenant-acme-corp-credentials

This ensures:

tenant secrets are isolated
credentials are centrally managed securely


## 🔗 STEP 2 — Google Service Account Creation

A dedicated GCP Service Account is created:

acme-corp-gsa

This identity is used for secure cloud access.


## 🔒 STEP 3 — IAM Scoped Access


The following role is granted:

roles/secretmanager.secretAccessor

Access is scoped ONLY to:

tenant-acme-corp-credentials

NOT the entire project.

## 🛡️ Why Scoped IAM Matters

If access were granted project-wide:

compromised pods could read all tenant secrets

By scoping IAM to a single secret:

compromised workloads can access only their own credentials

This prevents:

cross-tenant secret theft
privilege escalation


## 🔄 STEP 4 — Workload Identity

Kubernetes ServiceAccount is linked to:

Google Service Account

using:

Workload Identity

Flow:

Pod → Kubernetes SA → GCP SA → Secret Manager

Benefits:

no static credentials
no JSON keys
secure authentication


## 🔄 STEP 5 — External Secrets Operator

External Secrets Operator syncs:

GCP Secret Manager
        ↓
Kubernetes Secret

Applications consume Kubernetes secrets normally.


## 🌐 STEP 6 — Network Isolation

NetworkPolicy restricts egress traffic.

Allowed:

DNS access
tenant database access

Blocked:

internet access
cross-namespace communication
lateral movement

## 🛡️ Why NetworkPolicy Alone Is Not Enough

NetworkPolicy protects network traffic only.

It does NOT:

protect Kubernetes API permissions
isolate IAM access
isolate secrets
prevent cloud privilege misuse

True tenant isolation requires multiple layers:

RBAC
IAM
namespaces
secrets isolation
network isolation

This is called:

Defense in Depth

## ▶️ How to Apply
Apply Terraform Security Resources
```
terraform apply
```

Creates:

Secret Manager secret
GCP Service Account
IAM bindings
Apply Kubernetes Security Resources
```
kubectl apply -f kubernetes/acme-corp/
```

Creates:

ExternalSecret
NetworkPolicy
ServiceAccount patch

## 🔐 Security Outcome

After Task 2:

tenants cannot access each other’s secrets
cloud access is tightly scoped
workloads are network isolated
secrets are securely synchronized

This creates a production-grade security model for a shared SaaS platform.
