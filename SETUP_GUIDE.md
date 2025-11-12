# Face Recognition Setup Guide

## Current Status: Missing C++ Build Tools

### Step 1: Install Build Tools ⬅️ YOU ARE HERE
Download and install ONE of these options:

**Option A: Build Tools Only (Recommended - Smaller download)**
1. Go to: https://visualstudio.microsoft.com/downloads/
2. Download "Build Tools for Visual Studio 2022"
3. Install with "C++ build tools" workload

**Option B: Full Visual Studio Community**
1. Go to: https://visualstudio.microsoft.com/vs/community/
2. Download Visual Studio Community 2022
3. Install with "Desktop development with C++" workload

### Step 2: After Installation (Run these commands)
```cmd
# Restart your command prompt/VS Code after installation
pip install dlib
pip install face_recognition
pip install -r requirements.txt
```

### Step 3: Test the Installation
```cmd
python -c "import dlib, face_recognition; print('Success! All dependencies installed')"
```

### Step 4: Run the Project
```cmd
python main.py
```

## Alternative: Use Anaconda (Easier but larger download)
If the above doesn't work, you can also use Anaconda:
1. Download Anaconda from: https://www.anaconda.com/download
2. Install it
3. Open Anaconda Prompt and run:
   ```
   conda create -n face_recognition python=3.9
   conda activate face_recognition
   conda install -c conda-forge dlib opencv face_recognition pillow
   ```

## What this project does:
- Face recognition attendance system
- Anti-spoofing (detects fake photos)
- User registration and login tracking
- Real-time webcam interface
