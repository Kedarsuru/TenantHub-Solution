A real production issue this workflow could prevent is accidental
deletion of Kubernetes resources during a refactor.

For example, a developer might unintentionally remove a Namespace,
NetworkPolicy, or Secret reference from a Kustomize overlay.

The PR diff workflow would immediately show the exact rendered manifest
changes before merge, allowing reviewers to catch destructive changes
before they reach production.
