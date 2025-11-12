# Face Attendance System - Quick Start Guide

## ✅ Setup Complete!

The project is now fully configured and running.

## Project Summary

**Face Recognition Attendance System** with anti-spoofing detection
- Real-time face detection and recognition
- Anti-spoofing protection (prevents fake photos/videos)
- User registration and attendance tracking
- Login/logout logging with timestamps

## How to Run

### Option 1: Using PowerShell (Current Setup)
```powershell
# Activate virtual environment
.\venv_windows\Scripts\Activate.ps1

# Run the application
python main.py
```

### Option 2: Direct Execution (No activation needed)
```powershell
.\venv_windows\Scripts\python.exe main.py
```

## Using the Application

### First Time Setup - Register Users
1. Click **"Register New User"** button
2. Face the camera (ensure good lighting)
3. Enter a username
4. Click **"Accept"** to save the user

### Daily Use - Attendance Tracking
1. **Login**: Face the camera and click "Login" to mark arrival
2. **Logout**: Face the camera and click "Logout" to mark departure

### Features
- **Real-time webcam feed** - See yourself on screen
- **Face recognition** - Identifies registered users
- **Anti-spoofing** - Detects if you're using a photo/video instead of being present
- **Attendance log** - Saves to `log.txt` with timestamps
- **User database** - Stored in `db/` folder as pickle files

## Troubleshooting

### Camera not working?
- Close other apps using the webcam (Zoom, Teams, etc.)
- Check Windows Privacy Settings → Camera → Allow desktop apps

### Face recognition errors?
- Ensure good lighting
- Face the camera directly
- Register users with clear face images

### App won't start?
Make sure you're using the venv Python:
```powershell
.\venv_windows\Scripts\python.exe main.py
```

## Technical Details

### Installed Packages
- Python 3.10.11
- OpenCV 4.12.0 (computer vision)
- face_recognition 1.3.0 (face detection/recognition)
- dlib-bin 19.24.6 (face landmarks, prebuilt binary)
- Pillow 12.0.0 (image processing)
- NumPy 2.2.6 (numerical computing)
- PyTorch 2.9.1 (anti-spoofing neural network)

### Project Structure
```
├── main.py              # Main application GUI
├── util.py              # Utility functions (face recognition logic)
├── test.py              # Anti-spoofing test function
├── train.py             # Anti-spoofing model training (if needed)
├── db/                  # User face encodings (pickle files)
├── resources/           # Pre-trained models
│   ├── anti_spoof_models/  # Anti-spoofing neural networks
│   └── detection_model/    # Face detection models
├── log.txt              # Attendance log (generated on first login)
└── venv_windows/        # Virtual environment
```

### Files Generated
- `db/<username>.pickle` - Face encoding for each registered user
- `log.txt` - Attendance records (format: username,timestamp,in/out)

## Next Steps

### Test the System
1. Register yourself as a test user
2. Try logging in and out
3. Check `log.txt` for attendance records
4. Try with a photo to test anti-spoofing (should reject it)

### Add More Users
- Register each person who needs access
- One registration per person is enough
- Users can login/logout multiple times

### View Attendance
Open `log.txt` to see all attendance records:
```
John Doe,2025-11-12 14:30:15,in
John Doe,2025-11-12 18:45:22,out
Jane Smith,2025-11-12 09:00:05,in
```

## Notes

- **Camera Permission**: Windows may ask for camera permission on first run
- **Anti-spoofing**: The system uses AI to detect fake faces (photos/videos)
- **Performance**: First run may be slower while models load
- **Database**: Face encodings are stored locally in `db/` folder
- **Privacy**: No faces are stored, only mathematical encodings

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Ensure camera has good lighting
3. Verify all packages are installed: `.\venv_windows\Scripts\python.exe -c "import cv2, face_recognition, torch; print('OK')"`

---

**Created**: November 12, 2025
**Python Version**: 3.10.11
**Virtual Environment**: venv_windows/
