#!/bin/sh
#
# rebuild_base_image.sh - Build the base Jumper docker image.
#
# Extracts the image tag from the Dockerfile itself and uses it to tag the image.
#
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
#
# Feel free to change these variables, but if you do you must also change the other scripts and Dockerfiles to match.
contname="jumper"
image_name="jhazelwo/${contname}"
nodename="--hostname=${contname}"
runname="--name=${contname}"
#
build_rm="--force-rm=true"
build_context=$(dirname $0)/base/
version=`egrep '^ENV TAG ' ${build_context}/Dockerfile|awk '{print $3}'`
[ -z $version ] && oops "Failed to get version from Dockerfile. Looking for 'ENV TAG X.Y'"
docker build $build_rm --tag=${image_name}:${version} $build_context
if [ $? -eq 0 -a please_$1 = please_clean ]; then
    for this in `/usr/bin/docker images |grep '<none>'|awk '{print $3}'`; do
        /usr/bin/docker rmi $this
    done
fi
