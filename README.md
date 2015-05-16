SSL site scanner
================

Source code: [https://github.com/jumanjihouse/docker-ssllabs-scan]
(https://github.com/jumanjihouse/docker-ssllabs-scan)

Docker image: [https://registry.hub.docker.com/u/jumanjiman/ssllabs-scan/]
(https://registry.hub.docker.com/u/jumanjiman/ssllabs-scan/)


About
-----

This git repo downloads golang source code from
[https://github.com/ssllabs/ssllabs-scan]
(https://github.com/ssllabs/ssllabs-scan)
and builds a tiny docker image that scans secure websites
with the Qualys SSL Labs service.

The build takes about 30 seconds and results in a 5 MiB Docker image.
The image contains a static binary and CA certificates. Nothing else.

Before you use this tool please review the terms and conditions,
which can be found here:
[https://www.ssllabs.com/about/terms.html]
(https://www.ssllabs.com/about/terms.html)


License
-------

See [LICENSE.md](https://github.com/jumanjiman/docker-ssllabs-scan/blob/master/LICENSE.md)
in this git repo.


How-to
------

### Build

:warning: Build requires Docker 1.6.0 or later.

    make all


### Pull an already-built image

    docker pull jumanjiman/ssllabs-scan


### Run

    user@devenv:~/ssllabs-scan$ docker run --read-only --rm -it jumanjiman/ssllabs-scan https://github.com/
    2015/05/16 18:06:39 [INFO] SSL Labs v1.16.14 (criteria version 2009i)
    2015/05/16 18:06:39 [NOTICE] Server message: This assessment service is provided free of charge by Qualys SSL Labs, subject to our terms and conditions: https://www.ssllabs.com/about/terms.html
    2015/05/16 18:06:41 [INFO] Assessment starting: https://github.com/
    2015/05/16 18:08:21 [INFO] Assessment complete: https://github.com/ (1 host in 95 seconds)
        192.30.252.131: A+
    -snip copious json output-
    2015/05/16 18:08:21 [INFO] All assessments complete; shutting down
