@echo off
echo Testing Face Recognition Dependencies...
echo.

echo Testing basic Python packages...
python -c "import cv2; print('✓ OpenCV installed')" 2>nul || echo "✗ OpenCV missing"
python -c "import PIL; print('✓ Pillow installed')" 2>nul || echo "✗ Pillow missing"
python -c "import numpy; print('✓ NumPy installed')" 2>nul || echo "✗ NumPy missing"
python -c "import tkinter; print('✓ Tkinter available')" 2>nul || echo "✗ Tkinter missing"

echo.
echo Testing face recognition packages...
python -c "import dlib; print('✓ dlib installed')" 2>nul || echo "✗ dlib missing - NEED BUILD TOOLS"
python -c "import face_recognition; print('✓ face_recognition installed')" 2>nul || echo "✗ face_recognition missing"

echo.
echo Testing camera access...
python -c "import cv2; cap=cv2.VideoCapture(0); ret,_=cap.read(); cap.release(); print('✓ Camera access works' if ret else '✗ Camera access failed')" 2>nul

echo.
if exist "resources\anti_spoof_models" (
    echo ✓ Anti-spoofing models found
) else (
    echo ✗ Anti-spoofing models missing
)

echo.
echo ========================
echo SETUP STATUS SUMMARY:
echo ========================
python -c "
try:
    import dlib, face_recognition, cv2
    print('🟢 READY TO RUN - All dependencies installed!')
except ImportError as e:
    print('🔴 NOT READY - Missing dependencies')
    print('   Next step: Install Visual Studio Build Tools')
    print('   Then run: pip install dlib face_recognition')
" 2>nul

pause
