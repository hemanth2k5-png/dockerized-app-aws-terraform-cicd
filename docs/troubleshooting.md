# Troubleshooting log

Twenty real problems from building this project, in the order I met them. Each entry has the symptom, how I diagnosed it, the root cause, the fix and how I now prevent it. Entry 8 is the one I learned the most from.

Related: [incident reports](incidents/) for the two planned failure tests.

### 1. A PowerShell command failed because it used bash line continuation

- **Symptom:** A multi-line AWS CLI or Terraform command pasted into PowerShell failed.
- **Diagnosis:** The error pointed at the backslash at the end of the first line.
- **Root cause:** `\` continues a line in bash. PowerShell uses a backtick, and treats `\` as a normal character.
- **Fix:** Ran the command on a single line, or used a backtick for continuation.
- **Prevention:** Write every command for PowerShell from the start, and check the syntax before pasting.


### 2. A pull request showed Checks 0 because the workflow file was in the wrong folder

- **Symptom:** The pull request had no checks at all, so the CI workflow never ran.
- **Diagnosis:** Ran `git status` and listed the folder with `Get-ChildItem .github -Recurse`.
- **Root cause:** `deploy.yml` was not inside `.github/workflows/`, and GitHub only runs workflows from that folder.
- **Fix:** Moved the file to `.github/workflows/deploy.yml` and committed it on a new branch.
- **Prevention:** Run `Get-ChildItem .github -Recurse` before committing a workflow.

<p align="center"><img src="evidence/day5-03b-pr4-checks-zero.png" alt="The merged pull request shows Checks 0" width="680"><br><sub>The merged pull request shows Checks 0</sub></p>

### 3. Commits landed on main instead of the feature branch

- **Symptom:** Several times, a commit appeared on `main` when it should have been on a feature branch.
- **Diagnosis:** Ran `git branch --show-current` and `git log --oneline` and saw the commit on `main`.
- **Root cause:** I had not created or switched to the feature branch before committing.
- **Fix:** Moved the commit to a new branch with `git branch -f`, then reset local `main` with `git reset --hard origin/main`.
- **Prevention:** Run `git branch --show-current` before every commit, and create one branch per change.


### 4. Terraform failed because it ran in the wrong folder

- **Symptom:** `terraform init` or `plan` reported no configuration files, and a stray `terraform/terraform/` folder with an empty `oidc.tf` appeared.
- **Diagnosis:** Printed the working directory with `Get-Location` and listed the folders.
- **Root cause:** The command ran from the repository root, or from an empty directory, instead of the `terraform/` folder.
- **Fix:** Deleted the stray folder and re-ran the command from `terraform/`.
- **Prevention:** Run `Get-Location` before every Terraform command.


### 5. The ECR repository looked missing because the console was in the wrong region

- **Symptom:** The repository Terraform had created did not appear in the console.
- **Diagnosis:** Checked the region selector in the console header.
- **Root cause:** The console was set to a different region than `ap-south-2`. I made the same mistake on the first networking day, when the VPC pages showed another VPC in us-east-1.
- **Fix:** Switched the console region to Asia Pacific (Hyderabad).
- **Prevention:** Check the region selector first whenever a resource seems to be missing.

<p align="center"><img src="evidence/day2-04-console-wrong-region-vpc.png" alt="The VPC list in the wrong region shows a different VPC, not the project's" width="680"><br><sub>The VPC list in the wrong region shows a different VPC, not the project's</sub></p>
<p align="center"><img src="evidence/day2-05-console-wrong-region-map.png" alt="The resource map shows subnets in us-east-1" width="680"><br><sub>The resource map shows subnets in us-east-1</sub></p>

### 6. The pipeline could not load credentials because the secret was misnamed

- **Symptom:** The OIDC step reported that it could not load credentials from any provider and kept retrying.
- **Diagnosis:** Compared the repository secrets page with the workflow file.
- **Root cause:** The secret was named `AWS_ROLES_ARN` but the workflow reads `AWS_ROLE_ARN`, so the workflow received an empty value.
- **Fix:** GitHub cannot rename a secret, so I deleted it and created `AWS_ROLE_ARN` with the role ARN.
- **Prevention:** Copy secret names from the workflow file instead of typing them.

<p align="center"><img src="evidence/day6-03a-secret-misnamed.png" alt="The repository secret is named AWS_ROLES_ARN" width="680"><br><sub>The repository secret is named AWS_ROLES_ARN</sub></p>

### 7. The OIDC trust policy still held a placeholder repository name

- **Symptom:** The OIDC step kept retrying at "Assuming role with OIDC" and the job never passed.
- **Diagnosis:** Read the run log, searched `variables.tf` for `github_repo`, and read the live trust policy with `aws iam get-role`.
- **Root cause:** The `github_repo` variable still held the placeholder `<github-user>/<repo>`, so the trust policy's `sub` condition matched no real token.
- **Fix:** Set the real `owner/repo` value, applied only the role with `-target`, and re-ran the pipeline.
- **Prevention:** Search for `<` placeholders before applying: `Select-String -Path terraform\*.tf -Pattern "<"`.

<p align="center"><img src="evidence/day5-03-trust-policy-placeholder.png" alt="The trust policy with the placeholder repository name" width="680"><br><sub>The trust policy with the placeholder repository name</sub></p>
<p align="center"><img src="evidence/day6-03b-failed-run-assuming-role.png" alt="The OIDC step retrying at Assuming role with OIDC" width="680"><br><sub>The OIDC step retrying at Assuming role with OIDC</sub></p>
<p align="center"><img src="evidence/day6-03-failed-run-arn-invalid.png" alt="The same step failing after its retries. The error shown is: Could not assume role with OIDC: Request ARN is invalid" width="680"><br><sub>The same step failing after its retries. The error shown is: Could not assume role with OIDC: Request ARN is invalid</sub></p>

### 8. sts:AssumeRoleWithWebIdentity not authorized despite correct settings

- **Symptom:** The pipeline failed with "Not authorized to perform sts:AssumeRoleWithWebIdentity" even though the secret, OIDC provider, audience and region were all correct.
- **Diagnosis:** Ruled out each setting in turn, then read the failed `AssumeRoleWithWebIdentity` events in CloudTrail event history.
- **Root cause:** The token's `sub` claim contained numeric IDs (`repo:owner@id/repo@id:ref:refs/heads/main`), so the trust policy condition written as plain `owner/repo` never matched.
- **Fix:** Changed the condition to `StringEquals` with both subject formats, still pinned to `main`.
- **Prevention:** When a trust policy rejects a token, read the real claims in CloudTrail instead of assuming the documented format.

<p align="center"><img src="evidence/day6-10-trust-policy-fixed.png" alt="The trust policy now lists both subject formats, pinned to the main branch" width="680"><br><sub>The trust policy now lists both subject formats, pinned to the main branch</sub></p>

### 9. A region test left the workflow pointing at us-east-1, and the ECR push was denied

- **Symptom:** The push failed with a message that the assumed role is not authorized to perform `ecr:InitiateLayerUpload`.
- **Diagnosis:** Read the full error: the resource named in it was a repository in us-east-1.
- **Root cause:** A region test left `aws-region: us-east-1` in the workflow, and the role only has permission on the `ap-south-2` repository.
- **Fix:** Restored `ap-south-2` in the workflow.
- **Prevention:** Do not merge temporary test edits to `main`. This failure is also least privilege working as designed.

<p align="center"><img src="evidence/day6-05-ecr-denied-wrong-region.png" alt="The denied push to the us-east-1 repository" width="680"><br><sub>The denied push to the us-east-1 repository</sub></p>

### 10. The deploy could not find the instance because the Name tag was a guess

- **Symptom:** The deploy job stopped at "Find target instance" with "No running instance with Name tag ...".
- **Diagnosis:** Read the instance's `Name` tag in the Terraform code.
- **Root cause:** I had used a placeholder `dockerized-app-ec2`, but the Terraform tag is `"${var.project_name}-app"`, which is `dockerized-app-app`.
- **Fix:** Set `INSTANCE_NAME` in the workflow to `dockerized-app-app`.
- **Prevention:** Read the real tag with `Select-String` in the Terraform files before putting it in a workflow.


### 11. A push was rejected because origin/main was stale

- **Symptom:** `git push` was rejected as non-fast-forward, and `oidc-ssm.tf` was missing from the merged branch although the policy was live in AWS.
- **Diagnosis:** Compared local and remote history after a `git fetch`.
- **Root cause:** Local commits sat on top of an old `origin/main`.
- **Fix:** Fetched, then rebuilt the change on top of the current `origin/main`.
- **Prevention:** Run `git fetch` and `git pull` on `main` before creating a branch.


### 12. A full apply left the instance running overnight

- **Symptom:** The EC2 instance from the previous session was still running the next day.
- **Diagnosis:** Looked at the EC2 console in Hyderabad. It was the same instance that showed Online in Systems Manager the day before.
- **Root cause:** An earlier apply was never followed by a destroy.
- **Fix:** Ran `terraform destroy` and checked the console for leftovers.
- **Prevention:** End every session with `terraform destroy`, `terraform state list` (it must print nothing), and a look at the console for instances, volumes and Elastic IPs.

<p align="center"><img src="evidence/day7-03-instance-running.png" alt="The instance still running the day after it was created" width="680"><br><sub>The instance still running the day after it was created</sub></p>

### 13. deploy.yml contained two top-level env blocks

- **Symptom:** The workflow file had two `env:` blocks at the top level.
- **Diagnosis:** Read the top of the file after an edit.
- **Root cause:** A second block was added without merging it into the first, and YAML does not allow duplicate keys.
- **Fix:** Merged the variables into a single `env:` block.
- **Prevention:** After editing, check the top-level keys: `Select-String -Path .github\workflows\deploy.yml -Pattern "^env:"`.


### 14. A docs commit landed on the wrong branch

- **Symptom:** The documentation commit appeared on `feat/monitoring` instead of the docs branch.
- **Diagnosis:** `git branch --show-current` showed the feature branch.
- **Root cause:** I committed before switching branches.
- **Fix:** Moved the commit to the correct branch.
- **Prevention:** Check the branch before every commit, as in entry 3.


### 15. Files appeared empty in the editor

- **Symptom:** `app/app.py` and `deploy.yml` showed no content in the editor, and a new docs file was committed with nothing in it.
- **Diagnosis:** Compared the editor tab with the file on disk using `Get-ChildItem <file> | Select-Object Name, Length`.
- **Root cause:** The file on disk really was empty. I did not establish exactly why.
- **Fix:** Restored the two code files from Git and re-created the docs file, then saved it.
- **Prevention:** Check the file length after saving, and look at `git diff` before committing.


### 16. TFLint exited with code 2 on the bootstrap stack

- **Symptom:** The TFLint step failed with exit code 2.
- **Diagnosis:** Read the findings TFLint printed.
- **Root cause:** The bootstrap stack had no `required_version` and no version constraint on the AWS provider.
- **Fix:** Added `required_version` and pinned the provider to `~> 6.0`.
- **Prevention:** Run TFLint locally before opening the pull request.


### 17. The plan job could not load credentials

- **Symptom:** The `plan` job in `terraform-ci.yml` failed with "Could not load credentials".
- **Diagnosis:** Looked at which secret the step reads.
- **Root cause:** The `AWS_PLAN_ROLE_ARN` secret had not been created.
- **Fix:** Added the secret with the plan role ARN and re-ran with a new commit.
- **Prevention:** Create every secret a new workflow reads before the first run. A new commit is needed, because re-running old jobs reuses the old workflow file.


### 18. A Terraform edit was not saved, so validate failed on the old reference

- **Symptom:** `terraform validate` failed on a reference I had already changed in the editor.
- **Diagnosis:** Compared the file on disk with the editor, and ran `git diff`.
- **Root cause:** The edit to `oidc.tf` (switching to the shared OIDC provider data source) had not been saved.
- **Fix:** Saved the file and validated again.
- **Prevention:** Check `git diff` before validating or committing.


### 19. terraform init seemed to hang on the provider download

- **Symptom:** `terraform init` sat on "Installing hashicorp/aws" for a long time.
- **Diagnosis:** Checked that there was no error and that the network was working.
- **Root cause:** Most likely the first download of the large AWS provider package, which has to be fetched in every new working directory.
- **Fix:** Waited. It completed without any change.
- **Prevention:** Commit `.terraform.lock.hcl`, and expect the first init in a new folder to be slow.


### 20. build-deploy was red on main while the stack was destroyed

- **Symptom:** After merging Terraform changes, the deploy job on `main` failed.
- **Diagnosis:** Confirmed with `aws iam get-role --role-name github-actions-deploy`, which returned `NoSuchEntity`.
- **Root cause:** The deploy role and the instance live in the main stack, which was destroyed, so there was nothing to assume or deploy to.
- **Fix:** No fix was needed. I left the red runs in the history and did not re-run old runs.
- **Prevention:** `deploy.yml` now ignores docs and Terraform-only changes (`paths-ignore`). Apply the stack before merging application code, and the README says the stack is destroyed between sessions.

