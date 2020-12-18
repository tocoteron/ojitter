PHONY:=

PHONY += up
up:
	docker-compose up $(container)

PHONY += down
down:
	docker-compose down

DB_SERVICE:=db
DB_NAME:=ojitter
DB_PASSWORD:=ojitter

export DB_NAME DB_PASSWORD

PHONY += db/init
db/init:
	docker-compose exec $(DB_SERVICE) mysql \
		-u root -h localhost -p$(DB_PASSWORD) \
		-e "CREATE DATABASE \`$(DB_NAME)\`"

PHONY += db/drop
db/drop:
	docker-compose exec $(DB_SERVICE) mysql \
		-u root -h localhost -p$(DB_PASSWORD) \
		-e "DROP DATABASE \`$(DB_NAME)\`"

PHONY += db/client
db/client:
	docker-compose exec $(DB_SERVICE) mysql \
		-u root -h localhost -p$(DB_PASSWORD) $(DB_NAME)

PHONY += ec
ec:
	echo $(PHONY)

.PHONY: $(PHONY)
