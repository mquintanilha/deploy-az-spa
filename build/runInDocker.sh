#!/bin/bash

if [[ "${RUN_CONTAINER}" == "true" ]]; then

	docker run \
	--name ${PKG}-${TAG} \
	--detach \
	--publish ${PUB_CONTAINER_PORT}:${EXPO_CONTAINER_PORT} \
	${PKG}

	echo "Executando o container. Você poderá acessa-lo localmente."
	echo "http://localhost:${PUB_CONTAINER_PORT}"
	echo "Finalizando..."
	sleep 5
else
	echo "Build finalizado."
fi
