run-project:
	docker compose up -d --build

	# run project
	@echo "Grafana UI: http://localhost:3000"

test-api:
	
	chmod +x tests/run_tests.sh
	./tests/run_tests.sh

	curl -X POST "https://localhost/predict" \
     -H "Content-Type: application/json" \
     -d '{"sentence": "Oh yeah, that was soooo cool!"}' \
	 --user admin:admin \
     --cacert ./deployments/nginx/certs/nginx.crt;


