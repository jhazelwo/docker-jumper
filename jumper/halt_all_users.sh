#!/bin/sh
#
# halt_all_users.sh - Delete all jumper-user containers.
#
dockerrm() {
    for container in `docker ps -a|grep ' jumper-'|awk '{print $1}'`; do
        docker rm -f $container
    done
    exit 0
}
if [ "$1" = "--force" ]; then
    dockerrm
fi
docker ps -a|grep 'jumper-' || exit 0
while : ; do
    read -p "STOP and DELETE these Jumper containers? [y/N] " this
    case "${this}" in
        Y|y ) dockerrm;;
        N|n|'' ) exit 0;;
        * ) echo "Y or N";;
    esac
done
exit 1
