Scoping Secret Manager access to a single secret prevents lateral
movement attacks in a shared multi-tenant environment.

If a tenant workload or pod becomes compromised, the attacker can only
retrieve that tenant's credentials instead of accessing secrets for all
tenants in the project.

This follows least-privilege security principles and reduces blast radius.


NetworkPolicy alone is not sufficient for tenant isolation because it
only controls network traffic between workloads.

Without IAM isolation, RBAC restrictions, and scoped secret access,
a compromised workload could still access Kubernetes API resources or
cloud secrets belonging to other tenants.

True multi-tenant isolation requires defense in depth across network,
identity, and secret-management layers.
