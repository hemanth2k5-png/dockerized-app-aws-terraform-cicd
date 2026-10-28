# Terraform quality checks and remote state

## What runs on every Terraform pull request
- `terraform fmt -check`, `terraform validate` (main stack and bootstrap), TFLint, Checkov.
- A `plan` job that assumes a read-only AWS role through OIDC and prints only the summary line.

## Remote state
- State lives in an S3 bucket with versioning, encryption (SSE-S3), a public access block and a lifecycle rule that expires old versions after 90 days.
- Locking uses S3 native locking (`use_lockfile`).
- The bucket, the GitHub OIDC provider and the plan role live in a separate `bootstrap/` stack that is never destroyed. Its own state is local and git-ignored.

## Checkov results
- Main stack: 13 findings. Fixed 3 (EBS optimized, default security group locked down, no automatic public IP on the subnet). Accepted 10 with a written reason each, as inline `#checkov:skip` comments.
- Bootstrap: 5 findings. Fixed 1 (lifecycle rule). Accepted 4 with a reason each.
- Final scan: 134 passed, 0 failed, 14 skipped.

## TFLint results
- 2 findings in bootstrap (no `required_version`, no provider version constraint). Both fixed.

## Limits
- The main-stack fixes (EBS optimized, default security group, subnet IP setting) were validated and scanned, but not applied yet. They are first applied in the next full apply.
- PR plans run with `-lock=false`, because the plan role is read-only.
- The plan role uses AWS `ReadOnlyAccess`, which is broader than needed.
- The stack is destroyed between sessions, so a PR plan shows every resource as new. It checks that the configuration plans without errors, not what changes.
- Apply is manual.