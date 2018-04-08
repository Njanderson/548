dockerfile = $(abspath .)/Dockerfile
docker_image_name = cse548

default: build

build:
	docker build -f $(dockerfile) -t $(docker_image_name) .

run:
	docker run -it $(docker_image_name)

clean:
	@echo "[INFO] Open Makefile and check the rule called prune, also read README.md"

prune:
	docker image prune -a
