#!/bin/sh
#
# /jumper/bin/jump.sh - wrapper for sudo-jump.
# Only needed in jumper-root configurations.
#
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
sudo /jumper/sbin/sudo-jump.sh $@
