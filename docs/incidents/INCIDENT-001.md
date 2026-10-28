# INCIDENT-001: Application container stopped

**Type:** Planned failure test (injected on purpose), not a real outage.
**Date:** 23 October 2026
**Times:** IST from the laptop clock unless marked UTC. The instance clock is UTC. The two clocks can differ by a few seconds.

## Problem
The app container was stopped on the EC2 instance, so `/health` stopped returning HTTP 200.

## Timeline
| Time (IST) | Event |
|---|---|
| 22:59:30 | Container started (gunicorn startup lines in CloudWatch, 17:29:30 UTC) |
| 23:04:43 | Container received SIGTERM and shut down cleanly (17:34:43 UTC in CloudWatch) |
| 23:04:44 | Last successful `/health` check, and the stop command was issued |
| 23:04:46 | First failed `/health` check |
| about 23:07 | CloudWatch alarms page captured: both alarms still OK |
| 23:07:53 | Last failed `/health` check |
| 23:07:57 | First successful `/health` check after recovery |

## Detection
- A polling script requested `/health` every 2 seconds and logged the time and result. It showed the first failure at 23:04:46, 2 seconds after the last success.
- No alarm fired. At about 23:07 the CloudWatch alarms page showed both `dockerized-app-high-cpu` and `dockerized-app-status-check-failed` in OK. Both watch the instance, and the instance stayed healthy.
- The shutdown was visible afterwards in the CloudWatch log group `/dockerized-app/app`.

## Impact
- `/health` returned no HTTP 200 for about 3 minutes 13 seconds (193 s), measured from the last 200 (23:04:44) to the first 200 after recovery (23:07:57). The first to last failed checks span 187 s.
- No data was lost, because the app is stateless.

## Root cause
The container was stopped with `docker stop app`, run through SSM. `docker ps -a` showed `Exited (0)`, and the logs showed gunicorn handling a termination signal and shutting down cleanly, so this was not a crash. The container uses `--restart unless-stopped`, which deliberately does not restart a container that was stopped manually. A crash would have been restarted automatically. The crash case was not tested.

## Investigation
1. `docker ps -a` showed the container in the Exited state with exit code 0.
2. `docker logs` and the CloudWatch logs showed `Handling signal: term`, `Worker exiting` and `Shutting down: Master`.
3. The instance itself was healthy: SSM stayed reachable and no instance alarm fired.

## Resolution
Started the container again with `docker start app`, run through SSM. The next `/health` check, at 23:07:57, returned HTTP 200.

## Recovery time
- Total outage, last 200 to first 200: about 193 seconds.
- Service restored: 23:07:57.
- The exact time the `docker start` command was issued was not recorded during the test, so a time from command to restored service is not reported.
- Measurement resolution is about 5 seconds. The script polled every 2 seconds, and failed requests added up to a 3-second timeout.

## Prevention
Ideas, none of which are built yet:
- An application-level health alarm (for example a Route 53 health check or a custom CloudWatch metric) so a stopped app sends an email without anyone polling.
- A process supervisor or health-based restart for the container.
- A load balancer health check (a stretch goal in the plan).