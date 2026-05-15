# Task 1 — Tenant Provisioning

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
