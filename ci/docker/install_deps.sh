#!/bin/bash -ex


is_redhat() {
  if [ -f /etc/redhat-release ]; then
    return 0
  fi

  return 1
}


install_pkg() {
    package=$1

    echo "Need to install $package package."

    if is_redhat; then
        sudo dnf install -y --skip-broken $package
        rpm -qv $package
    else
        sudo apt-get install -y $package
    fi
}


check_and_install_pkg() {
    tool=$1
    pkg=$2

    if [ -z $pkg ]; then
      pkg=$tool
    fi

    if ! which $tool 2>&1 > /dev/null; then
        install_pkg $pkg
    fi
}


check_dependencies() {
    which docker 2>&1 >/dev/null || (echo Please consider to install and configure docker service to continue.; return 1)
    check_and_install_pkg weston
    check_and_install_pkg time
    check_and_install_pkg timeout coreutils
}


install_deps_main() {
    check_dependencies
}


if [ "$0" = "$BASH_SOURCE" ]; then
    install_deps_main
fi

