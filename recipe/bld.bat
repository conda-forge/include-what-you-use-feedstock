REM TODO(galexite): remove once llvm/llvm-project#83807 has been merged
echo from pathlib import Path                                                    >> _windows_patch.py
echo import re                                                                   >> _windows_patch.py
echo cmakelists = Path.cwd() / 'CMakeLists.txt'                                  >> _windows_patch.py
echo contents = cmakelists.read_text(encoding='utf-8')                           >> _windows_patch.py
echo contents = re.sub(                                                          >> _windows_patch.py
echo   r'project\(([^^\n]+)\)',                                                  >> _windows_patch.py
echo   r'project(\1 LANGUAGES CXX)\ninclude(GNUInstallDirs)', contents, count=1) >> _windows_patch.py
echo cmakelists.write_text(contents, encoding='utf-8')                           >> _windows_patch.py
python _windows_patch.py
if %ERRORLEVEL% neq 0 exit 1
del _windows_patch.py

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
