build:
	docker compose up --build
remove:
	docker compose down -v
	docker rmi spark-image
	docker rmi spark:4.0.1-scala2.13-java21-ubuntu
	docker builder prune -af
	docker system prune -af --volumes
	sudo rm -rf ./data/*
	sudo rm -rf ./scripts/*

check_file:
	docker exec spark-master ls -la /opt/spark/scripts/
run_job:
	docker exec spark-master spark-submit \
    --class Main \
    --master spark://spark-master:7077 \
    /opt/spark/scripts/dataingestionmaster_2.13-1.0.jar
