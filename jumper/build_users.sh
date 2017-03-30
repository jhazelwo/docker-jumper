#!/bin/sh
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
# build_users.sh - Do a docker build 1 or more user Dockerfiles.
# Extracts the image tag and username from the Dockerfile itself and uses those to name the user image.
#
# Without args: build all Dockerfiles found in jumper/users/ recursively
# args can be Dockerfiles or directories
#
# Usage Examples:
# ./build_users.sh
# ./build_users.sh users/corp/
# ./build_users.sh users/corp/*
# ./build_users.sh users/corp/Dockerfile-c*
# ./build_users.sh users/Dockerfile-example
# ./build_users.sh users/Dockerfile-bob* users/devel/Dockerfile-stan users/sales/
#
oops(){ echo "${@}"; exit 1; }
build_context=$(dirname $0)/users/
. $(dirname $0)/cfg/settings.sh
if [ $# -eq 0 ]; then
    targets="`find $build_context -type f -name Dockerfile-\*`"
else
    for this in $@; do
        if [ -f $this ]; then
            targets="${targets} ${this}"
        elif [ -d $this ]; then
            targets="${targets} `find ${this} -type f -name Dockerfile-\*`"
        else
            oops "$this is not a file or directory"
        fi
    done
fi
for dockerfile in $targets; do
    PERSON=`egrep 'ENV PERSON ' $dockerfile|awk '{print $3}'|egrep "^[a-z0-9]+$"` || \
        oops "Failed to get PERSON from ${dockerfile}. Username must be numbers and/or lowercase letters only."
    docker build \
        --force-rm=true \
        --tag="${image_repo_name}/${container_name_prefix}-${PERSON}:${image_tag}" \
        --file="${dockerfile}" \
        $build_context || exit $?
done
