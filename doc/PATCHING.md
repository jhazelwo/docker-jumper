# Jumper image patching

## String trigger method

The simplest way to patch is to make a change to
[jumper/base/Dockerfile](/jumper/base/Dockerfile)
above the `apk update` line then rebuild the base image and all user
images.

* Example from [jumper/base/Dockerfile](/jumper/base/Dockerfile):

```dockerfile
FROM alpine:3.5
MAINTAINER "Jumper Admins" <jumper-admins@example.gov>
...
RUN echo "Last patched on 2017.03.18 -JH"
RUN apk update
...
```

Containers running old versions will stay in place until
  killed. New `docker run` calls will launch the patched verions. This
  is the most user-friendly approach as it allows you to patch at any
  time, but choose when each person's container is updated, so folks
  can have their downtime changed to suit their schedule.

### Quick and Dirty How-To:

__Warning, this will delete the running containers!__

```
sed -i -e "s/Patched .*$/Patched $(date)\"/g" jumper/base/Dockerfile
./jumper/halt_all_users.sh --force
./jumper/build_base.sh
./jumper/build_users.sh
./jumper/run_users.sh
```

## Tags method

Another way to handle patching would be to increment the image tag,
but that requires changing the image_tag varible in
[jumper/cfg/settings.sh](/jumper/cfg/settings.sh) and the `FROM` line
in __ALL__ of the Dockerfiles in [jumper/user/](/jumper/user/). After
you do that you need to do the halt/build/build/run procedure from
above.

In either case, using _latest_ as your image tag is __NOT__ recommended!
