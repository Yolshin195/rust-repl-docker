# Переменные
IMAGE_NAME = rust-repl
CONTAINER_NAME = rust-dev-env

# Автоматическое определение среды (предпочитаем podman, если он есть)
ifeq ($(shell command -v podman 2> /dev/null),)
    RUNTIME := docker
else
    RUNTIME := podman
endif

.DEFAULT_GOAL := help

.PHONY: help build run clean

help: ## Показать справку по командам
	@echo "Используется среда: $(RUNTIME)"
	@echo "Доступные команды:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Собрать образ
	$(RUNTIME) build -t $(IMAGE_NAME) .

run: ## Запустить контейнер
	$(RUNTIME) run --rm -it --name $(CONTAINER_NAME) $(IMAGE_NAME)

clean: ## Удалить образ
	$(RUNTIME) rmi $(IMAGE_NAME)