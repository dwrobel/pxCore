#!/bin/bash -ex

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd "${THIS_DIR}"

source ./install_deps.sh

do_cleanup=""
weston_pid=""


cleanup() {
    if [ -z "${do_cleanup}" ]; then
        return 0
    fi

    do_cleanup=""
    if [ -n "${weston_pid}" ]; then
        kill -9 $weston_pid
        weston_pid=""
    fi

    popd
}


start_weston() {
    weston --use-pixman "$@" &
    weston_pid=$!
    sleep 5
}


runner_test() {
    pushd examples/pxScene2d/src
    echo display=$DISPLAY
    ps aux | grep weston
    time timeout -s 9 10m docker-wrapper.sh ./pxscene.sh https://px-apps.sys.comcast.net/pxscene-samples/examples/px-reference/test-run/testRunner_v5.js?tests=file:../../../tests/pxScene2d/testRunner/tests.json 2>&1 | tee log.txt &
    sleep 600s
    popd
}


run_main() {
    ./install_deps.sh

    export PATH=$PATH:$PWD/fedora/

    pushd ../../
        docker-wrapper.sh ./_clean.sh
        docker-wrapper.sh ./_build-wayland-egl-sanitizer.sh
        start_weston
        runner_test
    popd

}


if [ "$0" = "$BASH_SOURCE" ]; then
    trap cleanup EXIT INT TERM
    do_cleanup=1

    run_main
fi
