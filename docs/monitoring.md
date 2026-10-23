# Monitoring

## What is monitored
- **Container logs:** the app container uses the Docker `awslogs` log driver and writes to the CloudWatch log group `/dockerized-app/app` (7-day retention).
- **Metrics:** EC2 `CPUUtilization`, a built-in metric that needs no agent.
- **Alarm:** `dockerized-app-high-cpu` goes to ALARM when average CPU is above 70% for two consecutive 5-minute periods. It publishes to an SNS topic that emails me, both on alarm and on recovery.

## Metrics vs logs vs traces
- **Metrics** are numbers over time (for example CPU %). They suit alarms and trends.
- **Logs** are event records (for example gunicorn printing a line). They explain what happened.
- **Traces** follow one request across several services. They are not used here because there is a single service.

## What was verified
- Gunicorn startup lines appeared in the `app` log stream in CloudWatch.
- The alarm showed OK state with the 70% threshold configured.
- The email notification path was tested by forcing the alarm state with `aws cloudwatch set-alarm-state`. The alert email arrived.

## Limits
- The logs show gunicorn startup lines only. Request logging (`--access-logfile -`) is not enabled yet.
- The alarm covers CPU only. A status check alarm and an application health alarm are not set up yet.
- The notification test forced the alarm state. It was not a real CPU spike.