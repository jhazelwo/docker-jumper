FROM alpine:3.5
MAINTAINER "Jumper Admins" <jumper-admins@example.gov>
ENV TAG 1.0
RUN install -m 0700 -o 0 -g 0 -d /root/tmp
RUN apk update && apk add --update openssh tini
RUN /usr/bin/ssh-keygen -A
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/jumper/sbin/jumperd"]
RUN echo "Patched Thu Jan  1 00:00:00 UTC 1970"
RUN apk upgrade

COPY spool/* /root/tmp/

RUN install -m 0755 -o 0 -g 0 -d \
    /jumper \
    /jumper/bin \
    /jumper/doc

RUN install -m 0700 -o 0 -g 0 -d \
    /root/.ssh \
    /jumper/cfg \
    /jumper/run \
    /jumper/sbin \
    /jumper/log

RUN install -m 0700 -o 1000 -g 1000 -d \
    /jumper/tmp \
    /jumper/home \
    /jumper/home/.ssh

RUN install -m 0444 -o 0 -g 0 /root/tmp/jumper_doc_banner /jumper/doc/banner
RUN install -m 0444 -o 0 -g 0 /root/tmp/etc_motd /etc/motd
RUN install -m 0600 -o 0 -g 0 /root/tmp/jumper_cfg_sshd_config /jumper/cfg/sshd_config
RUN install -m 0500 -o 0 -g 0 /root/tmp/jumperd /jumper/sbin/jumperd
RUN install -m 0600 -o 0 -g 0 /dev/null /jumper/cfg/RevokedKeys
RUN install -m 0600 -o 0 -g 0 /dev/null /jumper/log/jumper.log
RUN install -m 0600 -o 0 -g 0 /dev/null /jumper/log/syslog
RUN install -m 0500 -o 0 -g 0 /root/tmp/etc_passwd /etc/passwd
RUN install -m 0500 -o 0 -g 0 /root/tmp/etc_shadow /etc/shadow
RUN install -m 0640 -o 0 -g 1000 /dev/null /jumper/doc/AuthorizedKeysFile
RUN install -m 0600 -o 1000 -g 1000 /root/tmp/jumper_home_ssh_config /jumper/home/.ssh/config
RUN addgroup -g 1000 human
#
# If using a jumper-root type setup...
#RUN apk add sudo
#RUN install -m 0600 -o 0 -g 0 /root/tmp/sudoers-jumper /etc/sudoers.d/jumper
#RUN install -m 0600 -o 0 -g 0 /root/tmp/id_rsa.root /jumper/cfg/id_rsa.root
#RUN install -m 0600 -o 0 -g 0 /root/tmp/root_ssh_config /root/.ssh/config
#RUN install -m 0750 -o 0 -g 0 /root/tmp/sudo-jump.sh /jumper/sbin/sudo-jump.sh
#RUN install -m 0750 -o 0 -g 1000 /root/tmp/jump.sh /jumper/bin/jump.sh
#RUN install -m 0750 -o 0 -g 1000 /root/tmp/conqshell.sh /jumper/bin/conqshell.sh
#RUN ln -sv /jumper/bin/jump.sh /usr/local/bin/jump
#RUN ln -sv /jumper/bin/conqshell.sh /usr/local/bin/conqshell
# ...end if jumper-root

#
# If you want to use LDAP, IPA or some other directory service to authenticate your users
# then add the client installation and setup work here. Afterwards you may need to adjust
# spool/jumperd to either prevent it from creating a local user account, or do other work
# required by your software.
# HINT: Try to do as much work as possible in this Dockerfile. Avoid adding complexity to
# the user's Dockerfiles or the spool/jumperd script.
