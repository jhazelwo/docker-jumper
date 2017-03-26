# What I like about docker-jumper

1. Provisioning a user is just 3 variables.
1. Each user gets their own Dockerfile.
1. By default the three user variables do not need to be kept secret.
Storing them in a company's git repo isn't a big deal.
1. No passwords!
1. Updating an SSH key is simple.
1. Different users can have different software.
1. After patching the base image users can be restarted at different
times. This would have been a gigantic help to some of the customers
I had years ago.
1. No moving parts, it's all just Dockerfiles, an sshd config and some
shell code.
1. By default each container only allows 1 user, 1 key, and 1 auth
attempt per connection so it is nearly the most secure surface you can
have.
1. Cutting off an ex-employee is simple and fast, and their container
can be backed up and saved for as long as you want.
1. Managing ssh keys is very simple, and by default users cannot add
more keys directly to their container.

# What I do not like about docker-jumper

1. Memory consumption. Although memory is cheap and Alpine is tiny I
don't like that containers are 9.7MB at minimum.
1. In jumper-root setups root's private key must exist in the
container and keeping that key outside of change control is a subtle
but serious security concern.
    1. To be fair, though, any jump box that allows users to ssh into
     servers as root using keys faces the same challenge.
1. We have to run syslogd in each container. Cannot be helped, though,
logs without timestamps are practically useless.
