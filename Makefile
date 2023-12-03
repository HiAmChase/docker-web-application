NODE_IMAGE:=api-node
TAG:=1

export DATABASE_URL:=postgres://root:H6CcA5SeyB49G0qhMkrW@db:5432/postgres

build-node:
	cd api-node && docker build -t ${NODE_IMAGE}:${TAG} .

run:
	docker compose up -d
