#!/bin/bash -ex
#
# Author Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
#
# https://semaphoreci.com/ integration script
#
# Semaphoreci configuration setup:
#
# "Project settings"
# (1) "Build Settings"
#    (a) Leave "Setup" - leave empty
#    (b) Add new command line: ./ci/builds/semaphoreci.sh
# (2) "Platform"
#    (a) Select from "DOCKER (NATIVE)" "Ubuntu 14.04 LTS v1805"
# (3) "Environment Variables"
# (4) "Configuration files"
# (5) "Repository"
#    (a) Setup pxCore GitHub repository
# (6) "Branches"
#    (a) "Default branch" - "master"
#    (b) "Cancellation strategy" - "Don't cancel queued builds"
#    (c) "Fast failing" - "Fast failing enabled for all branches"
#    (d) "Priority branches" - leave untouched
#    (e) "Build new branches" - "Automatically"
# (7) "Build Scheduler" - leave untouched
# (8) "Docker Registry" - leave untouched
# (9) "Notifications"
#    (a) "Email" - set your e-mail
#    (b) "Webhooks" - "receive after builds" - "Failed only"
#    (c) "Campfire" - Receive after deploys" - "Failed only"
#(10) "Collaborators" - invite your friends
#(11) "Integrations" - leave untouched
#(12) "Badge" - leave untouched
#(13) "Admin"
#    (a) "Build options" - "Command timeout" - "90 minutes"
#

SCRIPT_DIR=$(cd `dirname $0` && pwd)

pushd "${SCRIPT_DIR}"

time ./dw.sh ./runall.sh "$@"
