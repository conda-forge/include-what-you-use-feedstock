mkdir build
cd build

cmake ^
  -G "Ninja" ^
  %CMAKE_ARGS% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_C_COMPILER=%CC% ^
  -DCMAKE_CXX_COMPILER=%CXX% ^
  ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build . -j%CPU_COUNT%
if %ERRORLEVEL% neq 0 exit 1

cmake --install . -v
if %ERRORLEVEL% neq 0 exit 1
