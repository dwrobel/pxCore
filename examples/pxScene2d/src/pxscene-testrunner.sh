#!/bin/bash
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

SCRIPT_DIR=$(cd `dirname $0` && pwd)
pushd $SCRIPT_DIR

PXSCENE_BIN="${PXSCENE_BIN:-./pxscene}"
PXSCENE_URL="${PXSCENE_URL:-https://px-apps.sys.comcast.net/pxscene-samples/examples/px-reference/test-run/testRunner_v5.js?tests=}"
PXSCENE_TEST="${PXSCENE_TEST:-file:../../../tests/pxScene2d/testRunner/tests.json}"

${DBG} ${PXSCENE_BIN} "${PXSCENE_URL}${PXSCENE_TEST}"

popd
