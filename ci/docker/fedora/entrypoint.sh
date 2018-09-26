#!/bin/bash -xe
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
#

groupadd --non-unique --gid $GID "$USER" || test $? = 9

grps=$(stat -c "%G" /dev/dri/card* 2>/dev/null || echo "")

if [ x${grps} != "x" ]; then
    grps="${grps},"
fi

grps=${grps}"wheel"

useradd --no-create-home -G $grps --uid $UID --gid $GID "$USER" || test $? = 9

if [ -z ${XDG_RUNTIME_DIR} ]; then
    XDG_RUNTIME_DIR=/run/user/$UID
    mkdir -p ${XDG_RUNTIME_DIR}
    chown $UID:$UID ${XDG_RUNTIME_DIR}
    chmod 0700 ${XDG_RUNTIME_DIR}
    export XDG_RUNTIME_DIR
fi

cd "$CWD"

preserved_envs="PATH,DISPLAY,WAYLAND_DISPLAY,XDG_RUNTIME_DIR,CC,CXX"

if [ -f /etc/profile.d/ccache.sh ] ; then

    if [ -w "$CACHE_DIR" ] && [ -d "$CACHE_DIR" ] ; then
        export CCACHE_DIR=$CACHE_DIR/ccache
        sudo -u "$USER" mkdir -p $CCACHE_DIR
        sudo -u "$USER" --preserve-env=CCACHE_DIR ccache --set-config=max_size=2G
        preserved_envs="$preserved_envs,CCACHE_DIR"
    fi

    sed -i 's/unset\ CCACHE_DIR/#unset\ CCACHE_DIR/g' \
           /etc/profile.d/ccache.sh

    source /etc/profile.d/ccache.sh

fi

sudo -H -u "$USER" --preserve-env=$preserved_envs "$@"

