#!/bin/sh
#
# /jumper/sbin/jumper.sh - wrapper script to setup user, start SSHD and SyslogD
# by: "John Hazelwood" <jhazelwo@users.noreply.github.com>
#
exec >> /jumper/log/jumper.log 2>&1
date
oops(){ echo "`date` `hostname` Missing variable $1, check the Dockerfile"; sleep 10 ; exit 1; }
test -n "$PERSON" || oops 'PERSON'
test -n "$PUBSSHKEY" || oops 'PUBSSHKEY'
test -n "$PORT" || oops 'PORT'
sed -i "s/__PERSON__:/$PERSON:/" /etc/passwd
sed -i "s/__PERSON__:/$PERSON:/" /etc/shadow
echo "${PUBSSHKEY}" > /jumper/doc/AuthorizedKeysFile
#
/usr/sbin/sshd -p $PORT -f /jumper/cfg/sshd_config
#
#
#
## SyslogD (choose only one)
# /sbin/syslogd -n -O /dev/console             # For use with `docker run --tty ...`
/sbin/syslogd -n -O /jumper/log/syslog         # Log to file, use with `docker run --detach ...`
# /sbin/syslogd -n -R loghost.company.edu:514  # Log to loghost like Splunk or ELK stack.
