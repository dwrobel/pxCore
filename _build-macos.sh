#!/bin/bash
mkdir -p build
pushd build
cmake \
  -DSUPPORT_NODE=ON \
  -DSUPPORT_DUKTAPE=OFF \
  -DBUILD_PX_TESTS=ON \
  -DBUILD_PXSCENE_STATIC_LIB=ON \
  -DPXSCENE_TEST_HTTP_CACHE=OFF \
  -DCMAKE_CXX_FLAGS="-O0 -g3" ..
time make -j$(getconf _NPROCESSORS_ONLN) VERBOSE=1 && echo "ok"
popd
