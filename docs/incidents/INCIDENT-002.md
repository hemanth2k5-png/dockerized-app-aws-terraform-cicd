# INCIDENT-002: HTTP ingress rule removed from the Security Group

**Type:** Planned failure test (injected on purpose), not a real outage.
**Date:** 24 October 2026
**Times:** IST. Monitor times come from the laptop clock. CloudTrail times come from AWS. The two clocks can differ by a few seconds.

## Problem
The inbound rule allowing HTTP (port 80) from the internet was removed from the application Security Group, so `/health` became unreachable from the internet.

## Timeline
| Time (IST) | Event |
|---|---|
| 16:53:38 | `RevokeSecurityGroupIngress` recorded in CloudTrail, by user `Sai-Admin` |
| 16:53:38 | Last successful `/health` check in the monitor log |
| 16:53:40 | First failed `/health` check |
| about 16:54 | `curl -v` with a 5-second limit times out |
| about 16:55 | Through SSM: container Up, port 80 listening, `localhost` returns 200 |
| about 16:56 | Rule list shows only the outbound rule remaining |
| about 16:57 | CloudTrail event located |
| about 16:58 | CloudWatch alarms page: both alarms still OK |
| about 16:58 | `terraform plan` shows 1 resource to add |
| 16:59:06 | `terraform apply` confirmed, and last failed check |
| 16:59:11 | First successful `/health` check after the fix |

Times marked "about" come from the capture times of the screenshots.

## Detection
- A polling script requested `/health` every 2 seconds and logged the time and result. The last success was at 16:53:38 and the first failure at 16:53:40. CloudTrail recorded the rule removal at 16:53:38.
- No alarm fired. Around 16:58 both `dockerized-app-high-cpu` and `dockerized-app-status-check-failed` were OK. Their last state changes (about 16:46 IST) were from before the test. Both alarms watch the instance, and nothing watches reachability from outside.

## Impact
- `/health` was unreachable for about 5 minutes 31 seconds (331 s), from the first failed check (16:53:40) to the first successful check after the fix (16:59:11). The first to last failed checks span 326 s.
- From the recorded rule removal at 16:53:38 to the first success is about 333 s.
- No data was lost, because the app is stateless.

## Root cause
The inbound port 80 rule was deleted with the AWS CLI, as a stand-in for a manual console change. CloudTrail recorded it as `RevokeSecurityGroupIngress` by the `Sai-Admin` user. Terraform's state still listed the rule, so the live infrastructure had drifted from the code.

## Investigation
1. `curl -v` with a 5-second limit against the public address ended with "Connection timed out after 5009 milliseconds". The connection was neither refused nor answered, which is what dropped packets look like.
2. Through SSM, `docker ps` showed the `app` container Up, `ss -tlnp` showed `docker-proxy` listening on port 80, and `curl` against `localhost/health` returned 200. The app was healthy, so the problem was on the path between the internet and the instance.
3. The Security Group rule list showed only the outbound rule. The inbound port 80 rule was gone.
4. CloudTrail showed the `RevokeSecurityGroupIngress` event at 16:53:38 against the application Security Group, with no error code.
5. The CloudWatch alarms page showed both alarms OK, so no automatic detection existed for this failure.
6. `terraform plan` refreshed the state, warned `AWS resource not found during refresh`, and planned `1 to add, 0 to change, 0 to destroy`: the missing ingress rule.

## Resolution
Ran `terraform apply` with no code changes, which recreated the ingress rule. The next `/health` check, at 16:59:11, returned HTTP 200.

## Recovery time
- Total outage, first failed check to first success: about 331 seconds.
- The fix landed between the last failed check (16:59:06) and the first success (16:59:11), which is within the polling resolution.
- The exact time the apply command started was not recorded, so a time from command start to restored service is not reported.
- Measurement resolution is about 5 seconds: 2-second polling plus a 3-second request timeout.

## Limits of this report
- The `curl -v` check was run once. It shows a single timeout, not a repeated measurement.
- The last successful check (16:53:38, laptop clock) and the CloudTrail event (16:53:38, AWS clock) are in the same second, so their order within that second cannot be established.

## Prevention
Ideas, none of which are built yet:
- Restrict who can edit Security Groups with IAM, and make changes through Terraform.
- Run `terraform plan` on a schedule to detect drift.
- Add an external health check alarm, because the instance alarms cannot see this failure.
- Add an AWS Config rule or a CloudTrail alarm on `RevokeSecurityGroupIngress`.