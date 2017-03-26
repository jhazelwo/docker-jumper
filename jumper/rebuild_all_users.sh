#!/bin/sh
#
# rebuild_all_users.sh - Do a docker build for each user's Dockerfile
#
# By default this script will search jumper/users/ recursively allowing you to organize your user's
# Dockerfiles into sub-directories.
#
# Extracts the image tag and username from the Dockerfile itself and uses those to name the user image.
#
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
set -x
oops(){ echo "${@}"; exit 1; }
#
build_rm="--force-rm=true"
base_tag="jhazelwo/jumper-"
build_context=$(dirname $0)/users/
for dockerfile in `find $build_context -type f -name Dockerfile-\*`; do
    person=`egrep 'ENV PERSON ' $dockerfile|awk '{print $3}'|egrep "^[a-z0-9]+$"` || \
        oops "Failed to get person from ${dockerfile}. Username must be numbers and/or lowercase letters only."
    version=`egrep '^ENV TAG ' $dockerfile|awk '{print $3}'`
    [ -z $version ] && oops "Failed to get version from Dockerfile. Looking for 'ENV TAG X.Y'"
    docker build $build_rm --tag="${base_tag}${person}:${version}" --file=$dockerfile $build_context || exit $?
done
#
if [ $? -eq 0 -a please_$1 = please_clean ]; then
    for this in `/usr/bin/docker images |grep '<none>'|awk '{print $3}'`; do
        /usr/bin/docker rmi $this
    done
fi
