#!/bin/bash -e

# Usage: build.sh [--clean]
# Examples:
#  $ ./build.sh                # building
#  $ ./build.sh --clean        # cleaning
#  $ ./build.sh --force-clean  # force-cleaning

CWD=$PWD

DIRECTORY=$(cd `dirname $0` && pwd)

pushd $DIRECTORY
    if [[ "$#" -eq "1" && "$1" == "--clean" ]]; then
        make clean
    elif [[ "$#" -eq "1" && "$1" == "--force-clean" ]]; then
        git clean -fdx .
        git checkout .
    else
        make
    fi
popd
