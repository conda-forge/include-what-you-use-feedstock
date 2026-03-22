#!/usr/bin/env bash

# Possible upstream bug? Nothing obviously different between us and upstream CI.
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  cat <<EOF >>CMakeLists.txt
find_package(Threads REQUIRED)
target_link_libraries(iwyu-gtest PUBLIC Threads::Threads)
EOF
fi

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
