#!/bin/sh
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
# run_users.sh - Launch containers from existing images.
# Extracts the image tag, user name  and ports from the Dockerfiles and uses them to run the containers.
#
# By default this script will search jumper/users/ recursively allowing you to organize your user's
# Dockerfiles into sub-directories.
#
# Usage Examples:
# ./run_users.sh
# ./run_users.sh users/corp/
# ./run_users.sh users/corp/*
# ./run_users.sh users/corp/Dockerfile-c*
# ./run_users.sh users/Dockerfile-example
# ./run_users.sh users/Dockerfile-bob* users/devel/Dockerfile-stan users/sales/
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
    PORT=`egrep 'ENV PORT ' $dockerfile|awk '{print $3}'|egrep "^[0-9]{1,5}$"` || \
        oops "Failed to get PORT from ${dockerfile}. Looking for 'ENV PORT #####'"
    #
    #
    #volumes="-v /export/home/${PERSON}:/jumper/home"  # Map NFS to home dir in container.
    #
    #
    docker run ${volumes} \
        --hostname="${container_name_prefix}-${PERSON}" \
        --name="${container_name_prefix}-${PERSON}" \
        --detach \
        --publish="${PORT}:${PORT}" \
        --restart=unless-stopped \
        "${image_repo_name}/${container_name_prefix}-${PERSON}:${image_tag}"
done
