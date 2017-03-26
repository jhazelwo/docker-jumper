#!/bin/sh
#
# conqshell.sh - Run commands on remote systems concurrently.
# Only needed in jumper-root configurations.
# This is run as local user on jumper host.
#
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
set -e
ls $1 >/dev/null || exit $?
if [ ! "${1}" ]; then
    echo "
    $0 FILE COMMAND

    FILE is a file containing new-line separated list of servers to run commands on.
    COMMAND is the command, or commands, to run on each server.

    "
    exit 1
fi
tier_file=`realpath $1`
workdir="`/bin/mktemp -d -t $(date '+%s').XXXXXX -p /jumper/tmp`/"
echo $workdir
cd $workdir
shift
encoded_args=`echo "$@"|base64|tr -d '\n'`
echo "${@}" > command
# Create and fork-run task files.
for server in `egrep "^[a-z0-9A-Z]" ${tier_file}|awk '{print $1}'`; do
    echo "/jumper/bin/jump.sh ${server} 'echo ${encoded_args}|base64 -d|sh'" > task_${server}
    echo "rm task_${server}" >> task_$server
    sh task_${server} > ${server}.log 2>&1 &
done
# Wait for all tasks to complete.
while [ 1 ]; do
    ls task_* > /dev/null 2>&1 || exit 0
    sleep 1
done
