default: build

build:
	bundle exec jekyll clean
	bundle exec jekyll build

run: build
	bundle exec jekyll serve --watch

deploy: build
	rsync -r _site/ root@patrickbrown.dev:/var/www/html/