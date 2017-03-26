#!/bin/sh
#
# stop_all_users.sh - Stops, but does not delete, all Jumper user containers.
#
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
for container in `docker ps -a|grep ' jumper-'|awk '{print $1}'`; do
    docker stop $container
done
