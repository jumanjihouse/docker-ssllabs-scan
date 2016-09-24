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
	docker cp scanbuild:/tmp/ssllabs-scan-1.3.0/ssllabs-scan .

certfile: static
	docker cp scanbuild:/etc/ssl/certs/ca-certificates.crt .

runtime: static certfile
	docker build \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg VCS_REF=${VCS_REF} \
		--build-arg VERSION=${VERSION} \
		-t jumanjiman/ssllabs-scan -f Dockerfile.runtime .
	docker images | grep ssllabs-scan

test:
	# Check that image exists.
	docker images | grep ssllabs-scan

	# Check that binary has read-only relocations.
	readelf -lW ssllabs-scan | grep GNU_RELRO

	# Check that binary is static.
	file ssllabs-scan | grep -oh 'statically linked'

	# Check that binary is stripped (no debug symbols).
	file ssllabs-scan | grep -oh 'stripped'

	# Check that binary works.
ifdef CIRCLECI
	# Circle fails to drop all capabilities.
	docker run -it --read-only jumanjiman/ssllabs-scan -grade -usecache https://github.com
else
	docker run -it --read-only --cap-drop all jumanjiman/ssllabs-scan -grade -usecache https://github.com
endif
