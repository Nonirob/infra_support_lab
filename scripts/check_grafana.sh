#!/bin/bash

# Simple healthcheck script for Grafana.
# It is designed to be executed by cron and write results into a log file.
# Filebeat then collects this log and sends it to Elasticsearch.

LOG_FILE="/home/nonirob/elk-lab/logs/healthcheck.log"
TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Grafana often returns 302 on root URL because it redirects to /login.
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)

if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "302" ]; then
    echo "$TIME INFO Grafana is available (HTTP $HTTP_CODE)" >> "$LOG_FILE"
else
    echo "$TIME ERROR Grafana is unavailable (HTTP $HTTP_CODE)" >> "$LOG_FILE"
fi