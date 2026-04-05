# 50 Requests schnell hintereinander
for i in {1..1000}; do
  curl -s -o /dev/null -X POST "https://localhost/predict" \
    -H "Content-Type: application/json" \
    -d '{"sentence": "load test"}' \
    --user admin:admin \
    --cacert ./deployments/nginx/certs/nginx.crt
done
echo "Load test completed, sequentiell"


# and parralal with args

seq 30 | xargs -P 30 -I {} curl -s -o /dev/null \
  -X POST "https://localhost/predict" \
  -H "Content-Type: application/json" \
  -d '{"sentence": "load test"}' \
  --user admin:admin \
  --cacert ./deployments/nginx/certs/nginx.crt \
  -w "%{http_code}\n"

echo "Load test completed, with args for parallel execution"

# seq liek lequence, xargs -P 30 "parallel processes", I {} bracket for seq, -s silent, -o puts response body into "/dev.."
 