# smith-inception #

Yo Dawg, I heard you liked
[microcontainers](https://blogs.oracle.com/developers/the-microcontainer-manifesto),
so I put microcontainers in your microcontainers.

## Requirements ##

* docker
* network access

## Building the smith image ##

    ./build.sh

After a few minutes, the smith smith.tar.gz will be created. Note that future
runs should be much faster we cache most of the mock and yum data in a volume.

## What? ##

This uses a [smith](https://github.com/oracle/smith) container to build a smith
container. It turns out that mock is very hard to put in a microcontainer
because it has weird requirements for users and shells out to many other
programs. The results of the crazy hoop-jumping can be viewed in
[smith.template.yaml](smith.template.yaml).
