default: build

build:
	bundle exec jekyll clean
	bundle exec jekyll build

run: build
	bundle exec jekyll serve --watch

# CI/CD ONLY
pre_deploy:
	'which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )'
	eval $(ssh-agent -s)
	echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	echo "$SSH_KNOWN_HOSTS" > ~/.ssh/known_hosts
	chmod 644 ~/.ssh/known_hosts
	apt-get update && apt-get -y install rsync
	bundle install

# CI/CD ONLY
deploy: build
	rsync -r _site/ root@patrickbrown.dev:/var/www/html/