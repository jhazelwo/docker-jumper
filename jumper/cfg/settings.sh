#!/bin/sh
#
# settings.sh - variables sourced by the jumper/*.sh scripts.
#
# Your company name
image_repo_name="jhazelwo"
#
#
# Used when setting container names and hostnames of running containers.
# Must be short, letters and numbers. Should be all lowercase letters.
container_name_prefix="jumper"
#
# Tag used by all Images and Containers
# Warning, if you change this variable then you MUST update the 'FROM' line on ALL your Dockerfiles in jumper/users/ to
# match!
image_tag="1.0"
#
#
#
# These variables are typically used like this...
#
#   "${image_repo_name}/${container_name_prefix}-${PERSON}:${image_tag}"
#
# ...when creating images or running containers.
#
# A default example would be "jhazelwo/jumper-username:1.0"
#