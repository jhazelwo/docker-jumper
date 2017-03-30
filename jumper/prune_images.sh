#!/bin/sh
#
# prune_images.sh - Delete orphaned images.
#
destroy() {
    for this in `docker images |grep '<none>'|awk '{print $3}'`; do
        docker rmi $this
    done
    exit 0
}
if [ "$1" = "--force" ]; then
    destroy
fi
docker images |grep '<none>' || exit 0
while : ; do
    read -p "DELETE these orphaned images? [y/N] " this
    case "${this}" in
        Y|y ) destroy;;
        N|n|'' ) exit 0;;
        * ) echo "Y or N";;
    esac
done
exit 1
