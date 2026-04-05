#!/bin/bash

#  Sequential load test → v1
echo "Starting sequential load test (API v1)..."
for i in {1..50}; do
  curl -s -o /dev/null \
    -X POST "https://localhost/predict" \
    -H "Content-Type: application/json" \
    -d '{"sentence": "load test sequential"}' \
    --user admin:admin \
    --cacert ./deployments/nginx/certs/nginx.crt
done
echo "Load test completed, sequential (v1)"

# Sequential load test → v2
echo "Starting sequential load test (API v2 / A-B routing)..."
for i in {1..50}; do
  curl -s -o /dev/null \
    -X POST "https://localhost/predict" \
    -H "Content-Type: application/json" \
    -H "X-Experiment-Group: debug" \
    -d '{"sentence": "load test sequential v2"}' \
    --user admin:admin \
    --cacert ./deployments/nginx/certs/nginx.crt
done
echo "Load test completed, sequential (v2)"

# Parallel load test → Rate-Limiting trigger (30 all together, burst=20)
echo "Starting parallel load test (rate limiting)..."
seq 30 | xargs -P 30 -I {} curl -s -o /dev/null\
  -X POST "https://localhost/predict" \
  -H "Content-Type: application/json" \
  -d '{"sentence": "load test parallel"}' \
  --user admin:admin \
  --cacert ./deployments/nginx/certs/nginx.crt \
  -w "%{http_code}\n"
echo "Load test completed, parallel (rate limiting), breaks under the load with 503 errors"