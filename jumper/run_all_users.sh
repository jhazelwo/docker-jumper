#!/bin/sh
#
# run_all_users.sh - Launch containers from existing images.
#
# By default this script will search jumper/users/ recursively allowing you to organize your user's
# Dockerfiles into sub-directories.
#
# Extracts the image tag, usernames and ports from the Dockerfiles and uses them to run the containers.
#
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
oops(){ echo "${@}"; exit 1; }
base_tag="jhazelwo/jumper-"
build_context=$(dirname $0)/users/
for dockerfile in `find $build_context -type f -name Dockerfile-\*`; do
    PERSON=`egrep 'ENV PERSON ' $dockerfile|awk '{print $3}'|egrep "^[a-z0-9]+$"` || \
        oops "Failed to get PERSON from ${dockerfile}. Username must be numbers and/or lowercase letters only."
    PORT=`egrep 'ENV PORT ' $dockerfile|awk '{print $3}'|egrep "^[0-9]{1,5}$"` || \
        oops "Failed to get PORT from ${dockerfile}. Looking for 'ENV PORT #####'"
    version=`egrep '^ENV TAG ' $dockerfile|awk '{print $3}'`
    [ -z $version ] && oops "Failed to get version from Dockerfile. Looking for 'ENV TAG #.#'"
    nodename="--hostname=jumper-${PERSON}"
    runname="--name=jumper-${PERSON}"
    run_rm="--detach"
    ports="-p ${PORT}:${PORT}"
    #volumes="-v /export/home/${PERSON}:/jumper/home"  # Map NFS to home dir in container.
    startre="--restart=unless-stopped"
    image_name="${base_tag}${PERSON}:${version}"
    docker run $nodename $runname $run_rm $ports $volumes $startre $image_name
done
