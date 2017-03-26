#!/bin/sh
#
# jump.sh - ssh as root to a host
# Only needed in jumper-root configurations.
# This file is run as root via sudo.
#
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
oops(){ echo "${@}"; exit 1; }
if [ ! -w / ]; then
    oops "Must run as root"
fi
if [ ! -f "/root/.ssh/config" ]; then
    oops "root's .ssh/config file missing"
fi
if [ -z $1 ]; then
    oops "hostname required"
fi
destination=$1
if [ ! `echo $destination|egrep "^[a-zA-Z0-9\.\-]+$"` ]; then
    oops "Invalid hostname"
fi
ARGS=""
if [ $# -gt 1 ]; then
    shift
    # If all hosts have a base64 binary in path...
    ARGS="echo `echo "$@"|base64|tr -d '\n'`|base64 -d|sh"
    #
    # otherwise pass args raw but add slashes in front of dashes to guard against param injection.
    # ARGS=`echo "$@"|sed 's#\-#\\\-#g'`
fi
#
# Check /root/.ssh/config to see options used by this command.
ssh ${destination} "${ARGS}"
