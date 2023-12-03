NODE_IMAGE:=api-node
NODE_STAGE:=dev

GOLANG_IMAGE:=api-golang
GOLANG_STAGE:=dev

REACT_IMAGE:=client-react
NGINX_IMAGE:=client-nginx
TAG:=1

export DATABASE_URL:=postgres://root:H6CcA5SeyB49G0qhMkrW@db:5432/postgres

build-node:
	cd api-node && docker build --tag ${NODE_IMAGE}:${TAG} --target ${NODE_STAGE} .

build-golang:
	cd api-golang && docker build --tag ${GOLANG_IMAGE}:${TAG} --target ${GOLANG_STAGE} .

build-react:
	cd client-react && docker build -t ${REACT_IMAGE}:${TAG} -f Dockerfile.0 .

build-nginx:
	cd client-react && docker build -t ${NGINX_IMAGE}:${TAG} -f Dockerfile.1 .

run:
	docker compose up -d
