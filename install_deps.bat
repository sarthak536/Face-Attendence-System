@echo off
echo ============================================
echo Face Recognition Project - Dependency Setup
echo ============================================
echo.

REM Find and call vcvars64.bat for VS2019
set "VCVARS_PATH="
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
)
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
)
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat"
)
if exist "C:\Program Files\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_PATH=C:\Program Files\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
)
if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_PATH=C:\Program Files\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
)

if "%VCVARS_PATH%"=="" (
    echo ERROR: Could not find vcvars64.bat for Visual Studio 2019
    echo Please ensure Visual Studio 2019 Build Tools are installed with C++ workload
    pause
    exit /b 1
)

echo Found VS2019 at: %VCVARS_PATH%
echo Setting up Visual Studio environment...
call "%VCVARS_PATH%"
if errorlevel 1 (
    echo ERROR: Failed to set up VS environment
    pause
    exit /b 1
)

echo.
echo ============================================
echo Step 1: Upgrading pip, setuptools, wheel
echo ============================================
python -m pip install --upgrade pip setuptools wheel
if errorlevel 1 (
    echo ERROR: Failed to upgrade pip
    pause
    exit /b 1
)

echo.
echo ============================================
echo Step 2: Installing CMake
echo ============================================
pip install cmake
if errorlevel 1 (
    echo WARNING: CMake installation failed, continuing anyway
)

echo.
echo ============================================
echo Step 3: Installing dlib (this may take time)
echo ============================================
pip install dlib
if errorlevel 1 (
    echo ERROR: dlib installation failed
    echo This usually means:
    echo   - VS2019 C++ tools are not installed
    echo   - Missing Windows SDK
    echo   - CMake is not working
    pause
    exit /b 1
)

echo.
echo ============================================
echo Step 4: Installing face_recognition
echo ============================================
pip install face_recognition
if errorlevel 1 (
    echo ERROR: face_recognition installation failed
    pause
    exit /b 1
)

echo.
echo ============================================
echo Step 5: Installing other dependencies
echo ============================================
pip install opencv-python pillow numpy torch torchvision
if errorlevel 1 (
    echo ERROR: Failed to install some dependencies
    pause
    exit /b 1
)

echo.
echo ============================================
echo Step 6: Verifying installation
echo ============================================
python -c "import dlib; print('  OK: dlib')"
python -c "import face_recognition; print('  OK: face_recognition')"
python -c "import cv2; print('  OK: opencv-python')"
python -c "import PIL; print('  OK: pillow')"
python -c "import numpy; print('  OK: numpy')"
python -c "import torch; print('  OK: torch')"

echo.
echo ============================================
echo SUCCESS! All dependencies installed
echo ============================================
echo.
echo You can now run the project with:
echo   python main.py
echo.
pause
