
---

# 📄 `Task3`

```md id="9ogck4"
# 📡 Task 3 — Infrastructure Change Visibility

---

# 📖 Objective

The goal of Task 3 is to improve:

- infrastructure visibility
- deployment safety
- operational monitoring

This task introduces:
- PR-based Kubernetes diff visibility
- ArgoCD Slack health alerts

---

# 🧠 Problem Statement

Before this implementation:
- infrastructure PRs were merged blindly
- engineers could not see actual Kubernetes changes
- no automated deployment health notifications existed

This increases risk of:
- broken deployments
- accidental resource deletion
- production outages

---

# 🏗️ Architecture Flow

```text
Pull Request Opened
        ↓
GitHub Actions runs PR Diff Workflow
        ↓
Kustomize renders manifests
        ↓
Main branch vs PR branch compared
        ↓
Diff posted as PR comment
        ↓
ArgoCD monitors deployment health
        ↓
Slack alerts triggered on failures

```


## 🔍 STEP 1 — PR Diff Workflow


Workflow:
```
.github/workflows/pr-diff.yaml
```
runs on every Pull Request.

## ⚙️ Workflow Actions

The workflow:

checks out repository
builds manifests from main branch
builds manifests from PR branch
compares outputs
posts diff into PR comments


## 🧱 Why Kustomize Build?

Instead of comparing raw YAML files:
```
kustomize build .
```
renders final Kubernetes manifests.

This shows:

exact resources cluster will receive
actual deployment impact


## 🚨 Real Production Scenario

Example:

An engineer accidentally removes:

NetworkPolicy
RBAC Role
namespace resource

Git diff may not clearly show impact.

PR diff workflow immediately highlights:

deleted resources
changed permissions
dangerous modifications

This prevents production incidents before merge.

## 📡 STEP 2 — ArgoCD Notifications


ArgoCD continuously monitors:

desired Git state
actual cluster state

## 🚨 Alert Conditions

Slack alerts are sent when applications become:

Degraded
OutOfSync

Alerts include:

application name
environment
ArgoCD dashboard link

## 🛠️ Benefits

This improves:

deployment visibility
faster incident response
operational awareness
GitOps monitoring

## ▶️ How to Run
Generate Kustomize Output
```
kustomize build .
```
Output stored in:
```
kustomizeoutput.txt
```
GitHub Actions PR Workflow

Automatically runs on:

Pull Requests

No manual execution required.

## 📈 Operational Outcome

After Task 3:

infra changes become reviewable
deployment failures become visible quickly
engineers gain confidence before merging

This creates a safer GitOps deployment pipeline.



