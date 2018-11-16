#
# Copyright 2018 Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/sh

export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-WPE}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/0/}

. .pxsceneEnableRequire

readonly pxscenedir=/home/root
readonly executable=${pxscenedir}/pxscene

startWith() { case $2 in "$1"*) true;; *) false;; esac; }

# check if last argument is Node.js option or Spark URL {
if [ $# -gt 0 ]; then
    eval url="\${$#}"

    if startWith -- "${url}"; then
        url=""
    fi
fi

if [ "${url}" = "" ]; then
    # (if exists) use default url
    default_url="/home/root/refapp/src/main.js"
    [ -e ${default_url} ] && url=${default_url}
else
    url=""
fi
# }

# kill running Spark instances
ps aux | grep "${executable}" | grep -v grep | awk '{print $1}' | xargs -r kill -9

# execute the pxscene binary
(cd ${pxscenedir} && ${ENTRYPOINT} "${executable}" "$@" "${url}")

