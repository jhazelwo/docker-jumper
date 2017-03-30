# Project contents

## jumper

Scripts for managing jumper images and containers

* [build_base.sh](/jumper/build_base.sh) - Does
`docker build` for the base image
[base/Dockerfile](/jumper/base/Dockerfile)
* [build_users.sh](/jumper/build_users.sh) - Does
`docker build` for each Dockerfile-{username} in ./users/ but also
accepts Dockerfiles and/or directories as arguments to build instead.
* [run_users.sh](/jumper/run_users.sh) - Does `docker run` for each
Dockerfile-{username} in ./users/ but also accepts Dockerfiles and/or
directories as arguments to run instead.
* [start_all_users.sh](/jumper/start_all_users.sh) - Does
`docker start` for all existing jumper-username containers. Does not
build images. Does not create new containers.
* [stop_all_users.sh](/jumper/stop_all_users.sh) - Does `docker stop`
for all existing jumper-username containers. Does not delete data.
* [halt_all_users.sh](/jumper/halt_all_users.sh) - Does `docker rm -f`
for all container names matching 'jumper-*'.
__This deletes the running containers, erasing any data in the
containers, but does not delete the images__.
* [prune_images.sh](/jumper/prune_images.sh) - Deletes orphaned images.

### jumper/base

Build context for the base image.

* [Dockerfile](/jumper/base/Dockerfile) - The base image that all user
images inherit. This is where you'd put custom software installs that
all users need like LDAP/Kerberos/IPA/Splunk/or any other required
software clients.
* [spool/](/jumper/base/spool) - All config files, scripts and docs
needs by Jumper.

### jumper/users

Build context for user images.

* Dockerfile-{username} - A user image, this is where you define
username, port, ssh key and any additional software a specific user
would need.
* By default the included [build](../jumper/build_users.sh) and
[run](../jumper/run_users.sh) user scripts will __search
jumper/users/ recursively__ allowing you to organize your company's
Dockerfiles into sub-directories.
