deploy:
	git push origin master && cd _site && git add . && git commit -am "release" && git push origin gh-pages

setup:
	mkdir _site && cd _site && git init && git add . && git commit -am "initial commit" && git remote add origin git@github.com:changer/devlog.git

build:
	jekyll --pygments --no-lsi

server:
	jekyll --server --auto

.PHONY: deploy build
