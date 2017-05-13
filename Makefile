# vim: set ts=8 sw=8 ai noet:

.PHONY: all
all:
	@echo
	@echo 'WARNING: please run "ci/build" instead of "make all".'
	@echo
	@sleep 5
	ci/build

test:
	@echo
	@echo 'WARNING: please run "ci/test" instead of "make test".'
	@echo
	@sleep 5
	ci/test
