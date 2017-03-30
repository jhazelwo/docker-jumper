#!/bin/sh
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
# build_base.sh - Build the base Jumper docker image.
#
build_context=$(dirname $0)/base/
. $(dirname $0)/cfg/settings.sh
docker build \
    --force-rm=true \
    --tag="${image_repo_name}/${container_name_prefix}:${image_tag}" \
    $build_context
