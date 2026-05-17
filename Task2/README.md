
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
