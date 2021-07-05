# VAR AREA
PKG = nginx
TAG = latest
PUB_CONTAINER_PORT = 8080
EXPO_CONTAINER_PORT = 80
REPO_INFO ?= $(shell git config --get remote.origin.url)
COMMIT_SHA ?= git-$(shell git rev-parse --short HEAD)
BUILD_ID ?= "UNSET"
RUN_CONTAINER = false
REGISTRY = 8eab29e/remessa-corp

.EXPORT_ALL_VARIABLES: ## Exporta todas as variáveis.

.PHONY: image
image: clean-image build push
	@build/runInDocker.sh \
		PKG=$(PKG) \
		TAG=$(TAG) \
		PUB_CONTAINER_PORT=$(PUB_CONTAINER_PORT) \
		EXPO_CONTAINER_PORT=$(EXPO_CONTAINER_PORT) \
		RUN_CONTAINER=$(RUN_CONTAINER)

IMAGE_ID ?= $(shell docker images $(PKG) --format "{{.ID}}" )

.PHONY: clean-image
clean-image: ## Remove  a imagem local
ifeq ($(strip $(IMAGE_ID)),)
	echo "Sem imagens com a ref.: $(PKG) para remover"
else
	echo "Removendo imagens antigas com a ref.: $(PKG):$(TAG)"
	@docker rmi -f $(IMAGE_ID) || true
endif

.PHONY: build
build:
	echo "Iniciando build da imagem Docker..."
	@build/build.sh
		PKG=$(PKG)
		TAG=$(TAG)
		COMMIT_SHA=$(COMMIT_SHA)
	
.PHONY: push
push:
	echo "Publicando imagem em $(REGISTRY)"
	@docker tag $(PKG):$(TAG) $(REGISTRY):$(PKG)
	@build/publishImage.sh
		PKG=$(PKG)
		COMMIT_SHA=$(COMMIT_SHA)
