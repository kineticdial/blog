default: build

build:
	jekyll clean
	jekyll build

deploy: build
	rsync -r _site/ root@patrickbrown.dev:/var/www/html/