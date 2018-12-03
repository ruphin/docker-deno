build:
	docker build -t ruphin/deno .
	docker push ruphin/deno
.PHONY: build
