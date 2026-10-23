# Deployment mechanism

The pipeline deploys with AWS Systems Manager (SSM) Run Command, not SSH.

## Why SSM instead of SSH
- No port 22 open and no SSH key to store or rotate.
- It uses the same short-lived IAM credentials as the GitHub OIDC login, so the pipeline holds no long-lived keys.
- Every command is logged in AWS.
- The GitHub role may run only the `AWS-RunShellScript` document, and only on the app instance.

## Flow
1. Unit tests run on every push and pull request.
2. On a push to `main`, the pipeline assumes an AWS role through OIDC.
3. It builds the Docker image and pushes it to Amazon ECR, tagged with the commit SHA.
4. It finds the running instance by its `Name` tag.
5. SSM runs a script on the instance: log in to ECR, pull the SHA-tagged image, replace the running container.
6. The pipeline checks `/health` and fails the job unless it returns HTTP 200.

## Trade-offs and limits
- Single instance: a deploy briefly stops the container, so there is a few seconds of downtime.
- There is no automatic rollback. A rollback means redeploying a previous commit SHA.
- Docs-only changes do not trigger a deploy (`paths-ignore` in the workflow).