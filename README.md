SSL site scanner
================

[![](https://badge.imagelayers.io/jumanjiman/ssllabs-scan.svg)](https://imagelayers.io/?images=jumanjiman/ssllabs-scan:latest 'View image size and layers')&nbsp;
[![Circle CI](https://circleci.com/gh/jumanjihouse/docker-ssllabs-scan.png?circle-token=b75db48608f115c0cb9760708be3839b48d41f8e)](https://circleci.com/gh/jumanjihouse/docker-ssllabs-scan/tree/master 'View CI builds')

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

### Build and test

:warning: Build requires Docker 1.6.0 or later (for `docker build -f <dockerfile>`).

    make all
    make test


### Pull an already-built image

For user convenience, each published image is tagged with
`<upstream-version-number>-<git-short-hash>` to correlate
with both the upstream software release and the git commit
of this repo. The "latest" tag always points to the most
recent build.

    docker pull jumanjiman/ssllabs-scan:latest


### Run

The following example uses `--read-only` and `--cap-drop all` as recommended by the
[CIS Docker Security Benchmark](https://benchmarks.cisecurity.org/tools2/docker/CIS_Docker_1.6_Benchmark_v1.0.0.pdf).

    user@devenv:~$ docker_opts="--read-only --cap-drop all --rm -it"
    user@devenv:~$ image="jumanjiman/ssllabs-scan:latest"
    user@devenv:~$ scan_opts="-grade -usecache"
    user@devenv:~$ url_to_scan="https://github.com/"
    user@devenv:~$ docker run ${docker_opts} ${image} ${scan_opts} ${url_to_scan}
    2015/06/14 23:01:01 [INFO] SSL Labs v1.18.1 (criteria version 2009j)
    2015/06/14 23:01:01 [NOTICE] Server message: This assessment service is provided free of charge by Qualys SSL Labs, subject to our terms and conditions: https://www.ssllabs.com/about/terms.html
    2015/06/14 23:01:03 [INFO] Assessment starting: https://github.com
    2015/06/14 23:01:04 [INFO] Assessment complete: https://github.com (1 host in 96 seconds)
        192.30.252.129: A+
    "https://github.com": "A+"

    2015/06/14 23:01:04 [INFO] All assessments complete; shutting down
