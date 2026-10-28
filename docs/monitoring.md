# Monitoring

## What is monitored
- **Container logs:** the app container uses the Docker `awslogs` log driver and writes to the CloudWatch log group `/dockerized-app/app` (7-day retention).
- **Metrics:** EC2 `CPUUtilization` and `StatusCheckFailed`, built-in metrics that need no agent.
- **Alarms:** `dockerized-app-high-cpu` goes to ALARM when average CPU is above 70% for two consecutive 5-minute periods. `dockerized-app-status-check-failed` goes to ALARM when the EC2 status check fails for two consecutive 1-minute periods. Both publish to an SNS topic that emails me, on alarm and on recovery.

## Metrics vs logs vs traces
- **Metrics** are numbers over time (for example CPU %). They suit alarms and trends.
- **Logs** are event records (for example gunicorn printing a line). They explain what happened.
- **Traces** follow one request across several services. They are not used here because there is a single service.

## What was verified
- Gunicorn startup lines appeared in the `app` log stream in CloudWatch.
- The CPU alarm showed OK state with the 70% threshold configured.
- Both alarms showed OK in the console during the two planned incident tests, because neither test affected the instance itself (see INCIDENT-001 and INCIDENT-002).
- The email notification path was tested by forcing the alarm state with `aws cloudwatch set-alarm-state`. The alert email arrived.

## Limits
- The logs show gunicorn startup lines only. Request logging (`--access-logfile -`) is not enabled yet.
- The alarms cover CPU and EC2 status checks only. An application health alarm is not set up, so nothing alerts when the container stops or the Security Group changes.
- The notification test forced the alarm state. It was not a real CPU spike.