#!/bin/sh
#
# start_all_users.sh - Starts all existing jumper-user containers.
#
# This is only useful to re-start previously stopped containers.
#
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
for container in `docker ps -a|grep ' jumper-'|awk '{print $1}'`; do
    docker start $container
done
