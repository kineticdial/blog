default: build

build:
	jekyll clean
	jekyll build

run: build
	jekyll serve --watch

deploy: build
	rsync -r _site/ root@patrickbrown.dev:/var/www/html/