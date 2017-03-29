# Logging

Logging your Jumper containers.

## Using a Log host (recommended)

* It is __HIGHLY__ recommended that you set up a logging server
somewhere. It could be Splunk, or an ELK stack, or just a host with
syslog listening on port 514.
* Edit _./base/spool/init.sh_, comment out the syslogd line pointing to
local file (or console), and add something like this:
`/sbin/syslogd -n -R myloghost.example.gov:514`
* Please use a log host.

## Local logging (not recommended for production)

* Please switch to using a syslog host as soon as possible. Local file
logging is the default but is not meant for production use.
* By default the Jumper containers log to _/jumper/log/syslog_, a
file that is lost whenever the container is deleted.
* Please use a log host instead of local logging.
* Logs can be retained between cotnainer halts by mapping storage
from your Docker host to _/jumper/log/_ in the containers. See
_./docker/run_all_users.sh_ for an example on using the
`run -v` argument.

You can manually tail the log with:
`docker exec -ti jumper-{username} tail -f /jumper/log/syslog`

```
root@dockerhost01:$ docker exec -ti jumper-honeypot tail -f /jumper/log/syslog
Feb 31 00:12:12 jumper-honeypot syslog.info syslogd started: BusyBox v1.25.1
Feb 31 00:12:12 jumper-honeypot auth.info sshd[12]: Server listening on 0.0.0.0 port 22.
Feb 31 00:13:44 jumper-honeypot auth.info sshd[17]: Connection from {ip redacted} port 45034 on 172.17.0.5 port 22
Feb 31 00:24:30 jumper-honeypot auth.info sshd[18]: Connection from {ip redacted} port 34279 on 172.17.0.5 port 22
Feb 31 00:24:31 jumper-honeypot auth.info sshd[18]: User root from {ip redacted} not allowed because none of user's groups are listed in AllowGroups
Feb 31 00:24:31 jumper-honeypot auth.info sshd[18]: input_userauth_request: invalid user root [preauth]
Feb 31 00:24:31 jumper-honeypot auth.err sshd[18]: error: maximum authentication attempts exceeded for invalid user root from {ip redacted} port 34279 ssh2 [preauth]
Feb 31 00:24:31 jumper-honeypot auth.info sshd[18]: Disconnecting: Too many authentication failures [preauth]
```

## Other notes

* The last process launched is syslogd, so if that crashes the
container will die.
This is by design, we don't want traffic allowed if we cannot log it.
If syslogd is crashing, though, please open an
[issue](https://github.com/jhazelwo/docker-jumper/issues).
* `last`, `lastb` and `/var/log/[uwb]tmp` are not part of Alpine and
do not exist in the image, so there is no pretty output of failed or
successful log in attempts. SSHD's logging, however, is set such that
all attempts, successful or not, are logged. So you'll always have a
record in syslog.

> "Put your faith in the `logger`, your dsk belongs to me." -root
