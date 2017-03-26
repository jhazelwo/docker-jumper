# FAQ:

1. "How do I give some users extra software?"
    * Add the appropriate installation commands to their
    Dockerfile-{username}. Example: `RUN apk add git`
1. "How do I get into a container as root?"
    * On the Docker host: `docker exec -ti jumper-{username} /bin/sh`
1. "Is user data preserved between container restarts?"
    * Yes, unless deleted. Containers run in `--detach` mode and
    retain their data unless deleted with `docker rm`. __Note: the
    patching process requires old containers be deleted and the
    _halt_all_users.sh_ script deletes containers__.
1. "Is user data preserved between container rebuilds?"
    * By default, no.
1. "How can I make user's home directory persistent?"
    * Map a directory/drive/mount on your Docker host to /jumper/home
    in the container when the container is run. Check out the
    `run_all_users.sh` script for examples.
1. "What do I do when a user leaves the company?"
    1. `docker kill jumper-{username}`
    1. `mv /path/to/Dockerfile-{username} /somewhere/else/`
    1. `docker export jumper-{username} > /tmp/jumper-{username}.tar`
    1. `docker rm jumper-{username}`
    1. `docker rmi company/jumper-{username}:X.Y`
1. "How to limit which servers a person can jump to from Jumper?"
    * Not part of this product yet, and limiting hosts doesn't make
    sense unless using a jumper-root setup where access the private
    ssh key is protected with sudo.
1. "What about git, or other devel software?"
    * You can install anything you want by putting the needed commands
    in the Dockerfile, but jumper isn't meant to be a good devel
    environment. Your source control repos should have their own VIP(s)
    and your users should keep their local code on their workstations
    where their IDEs are. If you find your containers are getting too
    big you're probably using jumper the wrong way. Jumper is just an
    SSH tier.
1. "Can I use Ubuntu for the base Dockerfile instead?"
    * Yes, but each container's memory usage will be at least 10x
    greater. A base ubuntu:16.04 image is 129MB, alpine:3.5 is 3.9MB.
1. "How can I stop all containers for a bit without deleting them?"
    * `./jumper/stop_all_users.sh`
1. "How can I start all containers previously stopped?"
    * `./jumper/start_all_users.sh`
1. "What files need to be updated if I want to change the image tag?"
    * All of the Dockerfiles, base and user, and you have to change
    the `ENV TAG x.y` __and__ the `FROM jhazelwo/jumper:x.y` to all
    be the same, otherwise the rebuild and run scripts will break.
1. "This looks complicated."
    * Relax, it's just shell scripts, a couple Dockerfiles and
    customized but normal SSH configs.
1. "Can I use passwords? My employees don't know how to generate SSH
keys."
    * Don't give them system access. You have bigger problems.
1. "Oh, come on man, just tell me what to run."
    * `ssh-keygen -t rsa -b 8192 -f ~/.ssh/id_rsa -N ''`
    * The public key will be _~/.ssh/id_rsa.pub_
