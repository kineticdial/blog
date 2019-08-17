default: build

build:
	docker build -t kineticdial/blog . 
	docker run -v $(shell pwd):/blog kineticdial/blog jekyll clean
	docker run -v $(shell pwd):/blog kineticdial/blog jekyll build

deploy: build
	rsync -r _site/ root@patrickbrown.dev:/var/www/patrickbrown.dev/

deploy_staging: build
	rsync -r _site/ root@patrickbrown.dev:/var/www/staging.patrickbrown.dev/
