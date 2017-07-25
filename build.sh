#!/bin/bash
git submodule update --init --remote
VERSION=$(cd smith && make version)
(cd smith && make rpm/SOURCES/smith-${VERSION}.tar.gz)
(cd smith && make rpm/SPECS/smith.spec)
docker run -it --privileged -v $PWD:/write -v mock:/var/lib/mock -v cache:/var/cache --rm --entrypoint /usr/bin/mock vishvananda/smith \
	--buildsrpm --spec smith/rpm/SPECS/smith.spec --sources smith/rpm/SOURCES --resultdir smith/rpm
docker run -it --privileged -v $PWD:/write -v mock:/var/lib/mock -v cache:/var/cache --rm --entrypoint /usr/bin/mock vishvananda/smith \
    --rebuild smith/rpm/smith-${VERSION}-3.src.rpm --resultdir smith/rpm
RPM=smith/rpm/smith-${VERSION}-3.x86_64.rpm
sed "s;@RPM@;$RPM;" <smith.template.yaml >smith.yaml
docker run -it --privileged -v $PWD:/write -v mock:/var/lib/mock -v cache:/var/cache --rm vishvananda/smith -i smith.tar.gz
