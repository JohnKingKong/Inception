all:
	@mkdir -p /home/jvigneau/data/mariadb
	@mkdir -p /home/jvigneau/data/wordpress
	@docker compose -f ./scrs/docker-compose.yml up -d --build