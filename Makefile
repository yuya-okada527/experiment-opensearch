ca:
	git add .
	git commit -m "commit all"
	git push origin head
run:
	docker compose down
	docker compose up -d --remove-orphans
remove:
	docker compose down -v
