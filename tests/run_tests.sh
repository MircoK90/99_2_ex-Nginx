#!/bin/bash

echo "Testing HTTPS..."
curl -k https://localhost/predict -u admin:admin

echo "Testing A/B routing..."
curl -k -H "X-Experiment-Group: debug" https://localhost/predict -u admin:admin

echo "Testing rate limiting..."
for i in {1..20}; do
  curl -k https://localhost/predict -u admin:admin
done

echo "Testing load balancing..."
for i in {1..5}; do
  curl -k https://localhost/predict -u admin:admin
done
