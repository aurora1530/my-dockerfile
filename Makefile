DOCKERFILES := $(shell bash -c "find . -type f -name Dockerfile")
REPO_NAME := "my"

.PHONY: all
all:
	@for f in $(DOCKERFILES); do \
		tag=$$(dirname $$f | sed 's|^\./||; s|/|-|g'); \
		if [ -z "$$(docker images -q $(REPO_NAME):$$tag)" ]; then \
			echo "Building image $(REPO_NAME):$$tag from $$f"; \
			docker build -t $(REPO_NAME):$$tag -f $$f $$(dirname $$f); \
		else \
			echo "Image $(REPO_NAME):$$tag already exists. Skipping build."; \
		fi; \
	done

.PHONY: clean
clean:
	@for f in $(DOCKERFILES); do \
		tag=$$(dirname $$f | sed 's|^\./||; s|/|-|g'); \
		if [ -n "$$(docker images -q $(REPO_NAME):$$tag)" ]; then \
			echo "Removing image $(REPO_NAME):$$tag"; \
			docker rmi $(REPO_NAME):$$tag; \
		else \
			echo "Image $(REPO_NAME):$$tag does not exist. Skipping removal."; \
		fi; \
	done