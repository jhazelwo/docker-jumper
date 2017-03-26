# Flavors

There are a few ways to run a Jumper server

### jumper-user (default)

> I want my users to log into Jumper with a local account and then be
able to ssh normally to any server.

* SSH to Jumper as local user, then SSH to server as user.
* Lowest memory footprint.
* People use the normal ssh binary.

### jumper-root

> I want my users to log into Jumper with a local account and then be
able to ssh to any server as root.

* SSH to Jumper as user, then SSH to server as root.
* Copy of root's private key needs to be in the container. Put in
`docker/base/spool/id_rsa.root`
* Use sudo in container, force user to only use the jump and conqshell
scripts included with Jumper.

### jumper-user-ldap (or other directory service)

> I want my users to log into Jumper with an LDAP account and then be
able to ssh normally to any server.

* SSH to Jumper as LDAP user, then SSH to servers as user
* Requires LDAP install in base container which increases memory usage.

### jumper-root-ldap (or other directory service)

> I want my users to log into Jumper with an LDAP account and then be
able to ssh to any server as root.

* SSH to Jumper as LDAP user, then SSH to servers as root.
* Requires LDAP install in base container which increases memory usage.
* Copy of root's private key needs to be in the container. Put in
`docker/base/spool/id_rsa.root`
* Use sudo in container, force user to only use the jump and conqshell
scripts included with Jumper.

### jumper-team

> That's too many ports! I want each department to have their own
container+port

* Multiple users per container.
* Totally possible but not part of this product at this time.

## Using Docker volumes (or how I learned to stop worrying and use NFS)

* In the interests of increasing theoretical security you may want to
 use a Docker volume to map a directory on your Docker host to
 /jumper/cfg in the containers, and mount it read-only.
* You can give your users more storage by mapping elastic storage (like
NFS or EFS) on your Docker host to /jumper/home in your containers.
Doing so would also make it possible to retain user data after their
container is rebuilt (such as happens during patching).
