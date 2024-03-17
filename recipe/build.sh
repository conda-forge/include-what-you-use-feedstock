#!/usr/bin/env bash
mkdir -p build
cd build

cmake \
  -G "Ninja" \
  ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=${CC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  ..

cmake --build . -j${CPU_COUNT}
cmake --install . -v
