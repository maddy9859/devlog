deploy:
	git push origin master && cd _site && git add . && git commit -am "release" && git push origin gh-pages

build:
	jekyll --pygments --no-lsi

server:
	jekyll --server --auto

.PHONY: deploy build
