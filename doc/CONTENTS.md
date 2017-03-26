# Project contents

## jumper

Scripts for managing jumper images and containers

* halt_all_users.sh - Does `docker rm -f` for each
Dockerfile-{username} in ./users/. __This deletes the running
containers, erasing any data in the containers, but does not delete the
images__.
* rebuild_all_users.sh - Does `docker build` for each
Dockerfile-{username} in ./users/
* rebuild_base_image.sh - Does `docker build` for the base image
./base/Dockerfile
* run_all_users.sh - Does `docker run` for each Dockerfile-{username}
in ./users/
* start_all_users.sh - Does `docker start` for all existing
jumper-username containers. Does not build or create new
containers.
* stop_all_users.sh - Does `docker stop` for all existing
jumper-username containers. Does not delete data.

### jumper/base

Build context for the base image.

* Dockerfile - The base image that all user images inherit. This is
where you'd put custom software installs that all users need (like
LDAP).
* spool - All config files, scripts and docs needs by Jumper.

### jumper/users

Build context for user images.

* Dockerfile-{username} - A user image, this is where you define
username, port, ssh key and any additional software a specific user
would need.
* By default the included [build](../jumper/rebuild_all_users.sh) and
[run](../jumper/run_all_users.sh) user scripts will __search
jumper/users/ recursively__ allowing you to organize your user's
Dockerfiles into sub-directories.
