version=0.1.0
registry=eigr
proxy-image=${registry}/spawn-proxy:${version}
operator-image=${registry}/spawn-operator:${version}
activator-grpc-image=${registry}/spawn-activator-grpc:${version}
activator-http-image=${registry}/spawn-activator-http:${version}
activator-kafka-image=${registry}/spawn-activator-kafka:${version}
activator-pubsub-image=${registry}/spawn-activator-pubsub:${version}
activator-rabbitmq-image=${registry}/spawn-activator-rabbitmq:${version}
activator-sqs-image=${registry}/spawn-activator-sqs:${version}

.PHONY: all

all: build test build-all-images

clean:
	mix deps.clean --all

clean-all:
	mix deps.clean --all && kind delete cluster --name default

build:
	mix deps.get && mix compile

build-proxy-image:
	docker build -f Dockerfile-proxy -t ${proxy-image} .

build-operator-image:
	docker build -f Dockerfile-operator -t ${operator-image} .

build-all-images:
	docker build -f Dockerfile-proxy -t ${proxy-image} .
	docker build -f Dockerfile-operator -t ${operator-image} .
	docker build -f Dockerfile-activator-grpc -t ${activator-grpc-image} .
	docker build -f Dockerfile-activator-http -t ${activator-http-image} .
	docker build -f Dockerfile-activator-kafka -t ${activator-kafka-image} .
	docker build -f Dockerfile-activator-pubsub -t ${activator-pubsub-image} .
	docker build -f Dockerfile-activator-rabbitmq -t ${activator-rabbitmq-image} .
	docker build -f Dockerfile-activator-sqs -t ${activator-sqs-image} .

test:
	MIX_ENV=test PROXY_DATABASE_TYPE=mysql PROXY_HTTP_PORT=9001 SPAWN_STATESTORE_KEY=3Jnb0hZiHIzHTOih7t2cTEPEpY98Tu1wvQkPfq/XwqE= elixir --name spawn@127.0.0.1 -S mix test

push-all-images:
	docker push ${proxy-image}
	docker push ${operator-image}
	docker push ${activator-grpc-image}
	docker push ${activator-http-image}
	docker push ${activator-kafka-image}
	docker push ${activator-pubsub-image}
	docker push ${activator-rabbitmq-image}
	docker push ${activator-sqs-image}

create-k8s-cluster:
	kind create cluster -v 1 --name default --config kind-cluster-config.yaml
	kubectl cluster-info --context kind-default

delete-k8s-cluster:
	kind delete cluster --name default

load-k8s-images:
	kind load docker-image ${operator-image} --name default
	kind load docker-image ${proxy-image} --name default
	kind load docker-image ${activator-grpc-image} --name default
	kind load docker-image ${activator-http-image} --name default
	kind load docker-image ${activator-kafka-image} --name default
	kind load docker-image ${activator-pubsub-image} --name default
	kind load docker-image ${activator-rabbitmq-image} --name default
	kind load docker-image ${activator-sqs-image} --name default

generate-k8s-manifests:
	cd apps/operator && MIX_ENV=dev mix bonny.gen.manifest --image ${operator-image} --namespace eigr-functions

create-k8s-namespace:
	kubectl create ns eigr-functions

apply-k8s-manifests:
	kubectl -n eigr-functions apply -f apps/operator/manifest.yaml

run-proxy-local:
	cd apps/proxy && PROXY_DATABASE_TYPE=mysql SPAWN_STATESTORE_KEY=3Jnb0hZiHIzHTOih7t2cTEPEpY98Tu1wvQkPfq/XwqE= iex --name spawn_a2@127.0.0.1 -S mix

run-operator-local:
	cd apps/operator && MIX_ENV=dev iex --name operator@127.0.0.1 -S mix
	
run-proxy-image:
	docker run --rm --name=spawn-proxy -e PROXY_DATABASE_TYPE=mysql -e SPAWN_STATESTORE_KEY=3Jnb0hZiHIzHTOih7t2cTEPEpY98Tu1wvQkPfq/XwqE= --net=host ${proxy-image}

run-operator-image:
	docker run --rm --name=spawn-operator --net=host ${operator-image}