default: build

build:
	jekyll clean
	jekyll build
	docker build --rm -f "Dockerfile" -t blog:latest .

run:
	docker run --rm -it -p 80:80/tcp blog:latest