# vim: set ts=8 sw=8 ai noet:

.PHONY: all
all: runtime

clean:
	rm -f ca-certificates.crt || :
	rm -f ssllabs-scan || :
	docker rm -f scanbuild || :
	docker rmi -f scanbuild || :

static: clean
ifndef VERSION
	$(error VERSION environment variable is not set)
endif
	docker build \
		--build-arg version=${VERSION} \
		-t scanbuild -f Dockerfile.build .
	docker create --name scanbuild scanbuild true
	docker cp scanbuild:/tmp/ssllabs-scan-${VERSION}/ssllabs-scan .

certfile: static
	docker cp scanbuild:/etc/ssl/certs/ca-certificates.crt .

runtime: static certfile
	docker build \
		--build-arg CI_BUILD_URL=${CIRCLE_BUILD_URL} \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg VCS_REF=${VCS_REF} \
		--build-arg VERSION=${VERSION} \
		-t jumanjiman/ssllabs-scan -f Dockerfile.runtime .
	docker images | grep ssllabs-scan

test:
	@echo
	@echo 'WARNING: please run "ci/test" instead of "make test".'
	@echo
	@sleep 5
	ci/test
