# Jump tier using Docker containers

docker-jumper is a way to give your users, employees, or customers a
more secure and flexible jump tier.

* Each user gets their own container, running on their own port.
* No passwords! Containers only accept SSH keys.
* Tiny 9MB image size thanks to
[Alpine Linux](https://alpinelinux.org/).
* User provisioning is just 3 variables (name, port and public key) in
their own Dockerfile.

# Getting started

On your [Docker](https://www.docker.com/) host:

1. `git clone https://github.com/jhazelwo/docker-jumper.git`
1. `cd docker-jumper`
1. `./jumper/build_base.sh`
1. Look at the examples in [jumper/users/](jumper/users/) and create
your own _Dockerfile-username_, assign a port, pick a username and
paste the public SSH key. Remember to remove any
_jumper/users/Dockerfile-{username}_ files you don't want to create
images for.
1. `./jumper/build_users.sh`
1. `./jumper/run_users.sh`

You should be able to SSH as the user and port you specified using your
private key!

Example Dockerfile-username file:

```dockerfile
FROM jhazelwo/jumper:1.0
MAINTAINER "Jumper Admins" <jumper-admins@my-company.tld>
ENV PERSON zbeeblebrox
ENV PUBSSHKEY ssh-rsa AAAAB3NzEmmIKHw.......gt3gUNhANLmIokaw= me@laptop
ENV PORT 12345
```

# More info:

The [jumper/cfg/settings.sh](/jumper/cfg/settings.sh) file has the
repo name, container name and tag settings that the included scripts
use when building and running containers.

See the [doc](./doc/) directory for more documentation including a
[FAQ](doc/FAQ.md), the best ways to [Log](doc/LOGGING.md),
[Patch](doc/PATCHING.md), and [extend](doc/FLAVORS.md) your Jumper
install to do just about anything a jump tier can do.

> 'Image' vs. 'Container'; these words are used all throughout the
documentation and it is critical that their meaning is clearly
understood as they are related but different things. An image is a
compiled object, the result of a `docker build` command, and is akin to
a template. Images are built, not run. A container is a running process,
the result of a `docker run` command. Containers are based on an image,
much like object instantiation. Deleting a container does not delete
the image the container is based on. Deleting an image can only be done
if no containers running use the image. For programmers, an image is
like a class declaration, a container is like an instance of a class.

# Troubleshooting

Please open an
[issue](https://github.com/jhazelwo/docker-jumper/issues) if you run
into a problem.

# Development

Open beta!
[Pull Requests](https://github.com/jhazelwo/docker-jumper/pulls)
welcome!

### Bugs:

* None known at this time.

### TODO

* Host DB for jumper-root setups.
* Session data logging, for super-voyeur corporations. Forkers: Don't
use sudosh! It's not as solid as you might think.
* Group-based / multi-user containers. Almost defeats the purpose but
an easy fork candidate.
* Explain flavors more betterer.
