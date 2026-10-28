# Evidence gallery

Every screenshot taken during the project, in order. Account IDs, IP addresses and access keys are covered with solid boxes. Screenshots showing failures are kept on purpose; they are the evidence for the [troubleshooting log](../troubleshooting.md) and the [incident reports](../incidents/).


## Day 1: app, tests and Docker

<p align="center"><img src="day1-01-pytest-local-2-passed.png" alt="Pytest 2 passed on the laptop" width="720"><br><sub>day1-01-pytest-local-2-passed.png: Pytest 2 passed on the laptop</sub></p>

<p align="center"><img src="day1-02-docker-image-run.png" alt="Docker run of the local image" width="720"><br><sub>day1-02-docker-image-run.png: Docker run of the local image</sub></p>

<p align="center"><img src="day1-03-local-health-and-logs.png" alt="/health, / and gunicorn logs locally" width="720"><br><sub>day1-03-local-health-and-logs.png: /health, / and gunicorn logs locally</sub></p>


## Day 2: networking with Terraform

<p align="center"><img src="day2-01-plan-5-to-add.png" alt="Terraform plan: 5 to add (network)" width="720"><br><sub>day2-01-plan-5-to-add.png: Terraform plan: 5 to add (network)</sub></p>

<p align="center"><img src="day2-02-apply-confirm.png" alt="Apply confirmation prompt" width="720"><br><sub>day2-02-apply-confirm.png: Apply confirmation prompt</sub></p>

<p align="center"><img src="day2-03-apply-5-resources.png" alt="Apply complete: 5 resources" width="720"><br><sub>day2-03-apply-5-resources.png: Apply complete: 5 resources</sub></p>

<p align="center"><img src="day2-04-console-wrong-region-vpc.png" alt="Console VPC list in the wrong region (not the project VPC)" width="720"><br><sub>day2-04-console-wrong-region-vpc.png: Console VPC list in the wrong region (not the project VPC)</sub></p>

<p align="center"><img src="day2-05-console-wrong-region-map.png" alt="VPC resource map in us-east-1 (wrong region)" width="720"><br><sub>day2-05-console-wrong-region-map.png: VPC resource map in us-east-1 (wrong region)</sub></p>

<p align="center"><img src="day2-06-destroy-plan.png" alt="Destroy plan: 5 to destroy" width="720"><br><sub>day2-06-destroy-plan.png: Destroy plan: 5 to destroy</sub></p>

<p align="center"><img src="day2-07-destroy-complete.png" alt="Destroy complete: 5 destroyed" width="720"><br><sub>day2-07-destroy-complete.png: Destroy complete: 5 destroyed</sub></p>


## Day 3: security group, IAM and ECR

<p align="center"><img src="day3-01-plan-16-to-add.png" alt="Plan: 16 to add (SG, IAM, ECR)" width="720"><br><sub>day3-01-plan-16-to-add.png: Plan: 16 to add (SG, IAM, ECR)</sub></p>

<p align="center"><img src="day3-02-apply-16-resources.png" alt="Apply complete: 16 resources" width="720"><br><sub>day3-02-apply-16-resources.png: Apply complete: 16 resources</sub></p>

<p align="center"><img src="day3-03-ecr-repo.png" alt="ECR repository dockerized-app" width="720"><br><sub>day3-03-ecr-repo.png: ECR repository dockerized-app</sub></p>

<p align="center"><img src="day3-04-security-groups.png" alt="Application security group in the console" width="720"><br><sub>day3-04-security-groups.png: Application security group in the console</sub></p>

<p align="center"><img src="day3-05-ec2-role.png" alt="EC2 IAM role and attached policies" width="720"><br><sub>day3-05-ec2-role.png: EC2 IAM role and attached policies</sub></p>

<p align="center"><img src="day3-06-ecr-pull-policy.png" alt="Least-privilege ECR pull policy JSON" width="720"><br><sub>day3-06-ecr-pull-policy.png: Least-privilege ECR pull policy JSON</sub></p>

<p align="center"><img src="day3-07-destroy-confirm.png" alt="Destroy plan: 16 to destroy" width="720"><br><sub>day3-07-destroy-confirm.png: Destroy plan: 16 to destroy</sub></p>


## Day 4: first deployment to EC2

<p align="center"><img src="day4-01-plan-17-to-add.png" alt="Plan: 17 to add (first EC2)" width="720"><br><sub>day4-01-plan-17-to-add.png: Plan: 17 to add (first EC2)</sub></p>

<p align="center"><img src="day4-02-apply-prompt.png" alt="Plan 17 with approval prompt" width="720"><br><sub>day4-02-apply-prompt.png: Plan 17 with approval prompt</sub></p>

<p align="center"><img src="day4-03-apply-17-resources.png" alt="Apply complete: 17 resources" width="720"><br><sub>day4-03-apply-17-resources.png: Apply complete: 17 resources</sub></p>

<p align="center"><img src="day4-05-curl-health-ec2.png" alt="/health and / answering from EC2" width="720"><br><sub>day4-05-curl-health-ec2.png: /health and / answering from EC2</sub></p>

<p align="center"><img src="day4-07-instance-docker-ports.png" alt="Docker process, port 80 listening, docker logs on instance" width="720"><br><sub>day4-07-instance-docker-ports.png: Docker process, port 80 listening, docker logs on instance</sub></p>

<p align="center"><img src="day4-08-destroy-plan.png" alt="Destroy plan: 17 to destroy" width="720"><br><sub>day4-08-destroy-plan.png: Destroy plan: 17 to destroy</sub></p>

<p align="center"><img src="day4-09-destroy-complete.png" alt="Destroy complete: 17 destroyed" width="720"><br><sub>day4-09-destroy-complete.png: Destroy complete: 17 destroyed</sub></p>


## Day 5: GitHub OIDC and CI tests

<p align="center"><img src="day5-01-apply-summary.png" alt="Apply complete: 2 added (deploy role)" width="720"><br><sub>day5-01-apply-summary.png: Apply complete: 2 added (deploy role)</sub></p>

<p align="center"><img src="day5-01a-plan-oidc-targeted.png" alt="Targeted plan: OIDC provider and role" width="720"><br><sub>day5-01a-plan-oidc-targeted.png: Targeted plan: OIDC provider and role</sub></p>

<p align="center"><img src="day5-02-oidc-provider.png" alt="GitHub OIDC identity provider in IAM" width="720"><br><sub>day5-02-oidc-provider.png: GitHub OIDC identity provider in IAM</sub></p>

<p align="center"><img src="day5-03-trust-policy-placeholder.png" alt="Trust policy with the placeholder repo (before fix)" width="720"><br><sub>day5-03-trust-policy-placeholder.png: Trust policy with the placeholder repo (before fix)</sub></p>

<p align="center"><img src="day5-03b-pr4-checks-zero.png" alt="PR #4 merged with Checks 0 (workflow in wrong folder)" width="720"><br><sub>day5-03b-pr4-checks-zero.png: PR #4 merged with Checks 0 (workflow in wrong folder)</sub></p>

<p align="center"><img src="day5-04-pr-green-run.png" alt="CI test job green on a pull request" width="720"><br><sub>day5-04-pr-green-run.png: CI test job green on a pull request</sub></p>

<p align="center"><img src="day5-04b-pytest-2-passed.png" alt="CI test job: 2 passed" width="720"><br><sub>day5-04b-pytest-2-passed.png: CI test job: 2 passed</sub></p>

<p align="center"><img src="day5-05-main-green-run.png" alt="CI runs green on PR and main" width="720"><br><sub>day5-05-main-green-run.png: CI runs green on PR and main</sub></p>


## Day 6: build and push to ECR

<p align="center"><img src="day6-01-apply-ecr-and-policy.png" alt="Apply: ECR repo, lifecycle, ecr-push policy" width="720"><br><sub>day6-01-apply-ecr-and-policy.png: Apply: ECR repo, lifecycle, ecr-push policy</sub></p>

<p align="center"><img src="day6-02-ecr-repo-details.png" alt="ECR repository details" width="720"><br><sub>day6-02-ecr-repo-details.png: ECR repository details</sub></p>

<p align="center"><img src="day6-03-failed-run-arn-invalid.png" alt="Failed run: Could not assume role with OIDC" width="720"><br><sub>day6-03-failed-run-arn-invalid.png: Failed run: Could not assume role with OIDC</sub></p>

<p align="center"><img src="day6-03a-secret-misnamed.png" alt="Secret named AWS_ROLES_ARN" width="720"><br><sub>day6-03a-secret-misnamed.png: Secret named AWS_ROLES_ARN</sub></p>

<p align="center"><img src="day6-03b-failed-run-assuming-role.png" alt="OIDC step stuck on Assuming role" width="720"><br><sub>day6-03b-failed-run-assuming-role.png: OIDC step stuck on Assuming role</sub></p>

<p align="center"><img src="day6-05-ecr-denied-wrong-region.png" alt="ECR push denied (us-east-1 left in workflow)" width="720"><br><sub>day6-05-ecr-denied-wrong-region.png: ECR push denied (us-east-1 left in workflow)</sub></p>

<p align="center"><img src="day6-06-green-build-push.png" alt="Green test + build-push run" width="720"><br><sub>day6-06-green-build-push.png: Green test + build-push run</sub></p>

<p align="center"><img src="day6-07-ecr-sha-image.png" alt="ECR image tagged with commit SHA" width="720"><br><sub>day6-07-ecr-sha-image.png: ECR image tagged with commit SHA</sub></p>

<p align="center"><img src="day6-08-ecr-scan-results.png" alt="ECR scan-on-push findings" width="720"><br><sub>day6-08-ecr-scan-results.png: ECR scan-on-push findings</sub></p>

<p align="center"><img src="day6-09-role-ecr-push-policy.png" alt="Deploy role with ecr-push policy" width="720"><br><sub>day6-09-role-ecr-push-policy.png: Deploy role with ecr-push policy</sub></p>

<p align="center"><img src="day6-10-trust-policy-fixed.png" alt="Trust policy listing both sub formats (after fix)" width="720"><br><sub>day6-10-trust-policy-fixed.png: Trust policy listing both sub formats (after fix)</sub></p>


## Day 7: automated deploy with SSM

<p align="center"><img src="day7-01-plan-16-to-add.png" alt="Plan: 16 to add with approval" width="720"><br><sub>day7-01-plan-16-to-add.png: Plan: 16 to add with approval</sub></p>

<p align="center"><img src="day7-02-ssm-online.png" alt="SSM shows the instance Online" width="720"><br><sub>day7-02-ssm-online.png: SSM shows the instance Online</sub></p>

<p align="center"><img src="day7-03-instance-running.png" alt="EC2 console: instance running, 3/3 checks" width="720"><br><sub>day7-03-instance-running.png: EC2 console: instance running, 3/3 checks</sub></p>

<p align="center"><img src="day7-05-before-app-message.png" alt="App response before the pipeline change" width="720"><br><sub>day7-05-before-app-message.png: App response before the pipeline change</sub></p>

<p align="center"><img src="day7-06-role-ssm-policy.png" alt="Deploy role: ecr-push and ssm-deploy" width="720"><br><sub>day7-06-role-ssm-policy.png: Deploy role: ecr-push and ssm-deploy</sub></p>

<p align="center"><img src="day7-07-green-pipeline.png" alt="Green pipeline run after merge" width="720"><br><sub>day7-07-green-pipeline.png: Green pipeline run after merge</sub></p>

<p align="center"><img src="day7-08-after-app-message.png" alt="App response after the pipeline change" width="720"><br><sub>day7-08-after-app-message.png: App response after the pipeline change</sub></p>

<p align="center"><img src="day7-09-ecr-images.png" alt="ECR images tagged by SHA" width="720"><br><sub>day7-09-ecr-images.png: ECR images tagged by SHA</sub></p>

<p align="center"><img src="day7-10-ecr-image-scan.png" alt="ECR image details and scan" width="720"><br><sub>day7-10-ecr-image-scan.png: ECR image details and scan</sub></p>

<p align="center"><img src="day7-11-destroy-plan.png" alt="Destroy plan: 21 to destroy" width="720"><br><sub>day7-11-destroy-plan.png: Destroy plan: 21 to destroy</sub></p>

<p align="center"><img src="day7-12-destroy-complete.png" alt="Destroy complete: 21 destroyed" width="720"><br><sub>day7-12-destroy-complete.png: Destroy complete: 21 destroyed</sub></p>


## Day 8: monitoring

<p align="center"><img src="day8-01-plan-25-to-add.png" alt="Plan: 25 to add (with monitoring)" width="720"><br><sub>day8-01-plan-25-to-add.png: Plan: 25 to add (with monitoring)</sub></p>

<p align="center"><img src="day8-02-sns-confirm-email.png" alt="SNS subscription confirmation email" width="720"><br><sub>day8-02-sns-confirm-email.png: SNS subscription confirmation email</sub></p>

<p align="center"><img src="day8-03-green-pipeline.png" alt="Green pipeline for the monitoring change" width="720"><br><sub>day8-03-green-pipeline.png: Green pipeline for the monitoring change</sub></p>

<p align="center"><img src="day8-04-container-logs.png" alt="Gunicorn startup lines via aws logs tail" width="720"><br><sub>day8-04-container-logs.png: Gunicorn startup lines via aws logs tail</sub></p>

<p align="center"><img src="day8-05-alarm-high-cpu-ok.png" alt="CPU alarm in OK state, 70% threshold" width="720"><br><sub>day8-05-alarm-high-cpu-ok.png: CPU alarm in OK state, 70% threshold</sub></p>

<p align="center"><img src="day8-06-alarm-email.png" alt="Alarm email from the forced test" width="720"><br><sub>day8-06-alarm-email.png: Alarm email from the forced test</sub></p>


## Day 9: INCIDENT-001 (container stopped)

<p align="center"><img src="day9-01-plan-26-to-add.png" alt="Plan: 26 to add" width="720"><br><sub>day9-01-plan-26-to-add.png: Plan: 26 to add</sub></p>

<p align="center"><img src="day9-02-pipeline-health-check.png" alt="Pipeline run, health check step: HTTP 200" width="720"><br><sub>day9-02-pipeline-health-check.png: Pipeline run, health check step: HTTP 200</sub></p>

<p align="center"><img src="day9-03-baseline.png" alt="Baseline: /health ok, container Up" width="720"><br><sub>day9-03-baseline.png: Baseline: /health ok, container Up</sub></p>

<p align="center"><img src="day9-04-monitor-fail.png" alt="Monitor: 200 turns into FAIL" width="720"><br><sub>day9-04-monitor-fail.png: Monitor: 200 turns into FAIL</sub></p>

<p align="center"><img src="day9-05-alarms-ok.png" alt="Both alarms OK during the outage" width="720"><br><sub>day9-05-alarms-ok.png: Both alarms OK during the outage</sub></p>

<p align="center"><img src="day9-06-investigation.png" alt="Docker stop, Exited (0), shutdown logs" width="720"><br><sub>day9-06-investigation.png: Docker stop, Exited (0), shutdown logs</sub></p>

<p align="center"><img src="day9-07-monitor-recovered.png" alt="Monitor: FAIL back to 200" width="720"><br><sub>day9-07-monitor-recovered.png: Monitor: FAIL back to 200</sub></p>

<p align="center"><img src="day9-08-green-pipeline.png" alt="Green pipeline for the status-check alarm PR" width="720"><br><sub>day9-08-green-pipeline.png: Green pipeline for the status-check alarm PR</sub></p>

<p align="center"><img src="day9-09-destroy-plan.png" alt="Destroy plan: 26 to destroy" width="720"><br><sub>day9-09-destroy-plan.png: Destroy plan: 26 to destroy</sub></p>

<p align="center"><img src="day9-10-destroy-complete.png" alt="Destroy complete: 26 destroyed" width="720"><br><sub>day9-10-destroy-complete.png: Destroy complete: 26 destroyed</sub></p>


## Day 10: INCIDENT-002 (security group rule removed)

<p align="center"><img src="day10-01-plan-26-to-add.png" alt="Plan: 26 to add" width="720"><br><sub>day10-01-plan-26-to-add.png: Plan: 26 to add</sub></p>

<p align="center"><img src="day10-04-monitor-fail.png" alt="Monitor: last 200 at 16:53:38, first FAIL 16:53:40" width="720"><br><sub>day10-04-monitor-fail.png: Monitor: last 200 at 16:53:38, first FAIL 16:53:40</sub></p>

<p align="center"><img src="day10-05-curl-timeout.png" alt="Curl -v: connection timed out" width="720"><br><sub>day10-05-curl-timeout.png: Curl -v: connection timed out</sub></p>

<p align="center"><img src="day10-06-instance-healthy.png" alt="Via SSM: container Up, port 80 listening, localhost 200" width="720"><br><sub>day10-06-instance-healthy.png: Via SSM: container Up, port 80 listening, localhost 200</sub></p>

<p align="center"><img src="day10-07-sg-rules-missing.png" alt="Only the outbound rule remains" width="720"><br><sub>day10-07-sg-rules-missing.png: Only the outbound rule remains</sub></p>

<p align="center"><img src="day10-08-cloudtrail-revoke.png" alt="CloudTrail RevokeSecurityGroupIngress event" width="720"><br><sub>day10-08-cloudtrail-revoke.png: CloudTrail RevokeSecurityGroupIngress event</sub></p>

<p align="center"><img src="day10-09-alarms-ok.png" alt="Both alarms OK" width="720"><br><sub>day10-09-alarms-ok.png: Both alarms OK</sub></p>

<p align="center"><img src="day10-10-plan-drift.png" alt="Plan: 1 to add (drift)" width="720"><br><sub>day10-10-plan-drift.png: Plan: 1 to add (drift)</sub></p>

<p align="center"><img src="day10-11a-apply-plan.png" alt="Apply plan" width="720"><br><sub>day10-11a-apply-plan.png: Apply plan</sub></p>

<p align="center"><img src="day10-11b-apply-confirm.png" alt="Apply confirmation" width="720"><br><sub>day10-11b-apply-confirm.png: Apply confirmation</sub></p>

<p align="center"><img src="day10-12-monitor-recovered.png" alt="Monitor: FAIL back to 200" width="720"><br><sub>day10-12-monitor-recovered.png: Monitor: FAIL back to 200</sub></p>

<p align="center"><img src="day10-12b-first-last-fail.png" alt="First and last FAIL lines" width="720"><br><sub>day10-12b-first-last-fail.png: First and last FAIL lines</sub></p>


## Day 11: Terraform checks and remote state

<p align="center"><img src="day11-01-checkov-before.png" alt="Checkov main stack: 100 passed, 13 failed" width="720"><br><sub>day11-01-checkov-before.png: Checkov main stack: 100 passed, 13 failed</sub></p>

<p align="center"><img src="day11-02-checkov-after.png" alt="Checkov main stack: 103 passed, 0 failed, 10 skipped" width="720"><br><sub>day11-02-checkov-after.png: Checkov main stack: 103 passed, 0 failed, 10 skipped</sub></p>

<p align="center"><img src="day11-03a-bootstrap-plan-7.png" alt="Bootstrap plan: 7 to add" width="720"><br><sub>day11-03a-bootstrap-plan-7.png: Bootstrap plan: 7 to add</sub></p>

<p align="center"><img src="day11-04-state-bucket.png" alt="S3 state bucket: versioning enabled, Hyderabad" width="720"><br><sub>day11-04-state-bucket.png: S3 state bucket: versioning enabled, Hyderabad</sub></p>

<p align="center"><img src="day11-05-plan-role-trust.png" alt="Plan role trusts pull_request subjects" width="720"><br><sub>day11-05-plan-role-trust.png: Plan role trusts pull_request subjects</sub></p>

<p align="center"><img src="day11-06-bootstrap-lifecycle-plan.png" alt="Bootstrap plan: 1 to add (lifecycle rule)" width="720"><br><sub>day11-06-bootstrap-lifecycle-plan.png: Bootstrap plan: 1 to add (lifecycle rule)</sub></p>

<p align="center"><img src="day11-07-pr-checks.png" alt="All PR checks passed" width="720"><br><sub>day11-07-pr-checks.png: All PR checks passed</sub></p>

<p align="center"><img src="day11-09-failed-run.png" alt="Failed Terraform checks run on the PR" width="720"><br><sub>day11-09-failed-run.png: Failed Terraform checks run on the PR</sub></p>

<p align="center"><img src="day11-09b-failed-run-pr-status.png" alt="PR status while the Terraform checks were failing (kept in history)" width="720"><br><sub>day11-09b-failed-run-pr-status.png: PR status while the Terraform checks were failing (kept in history)</sub></p>
