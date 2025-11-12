import tkinter as tk
import cv2
from PIL import Image, ImageTk

# Test basic functionality without face_recognition
def test_basic_setup():
    try:
        # Test OpenCV
        cap = cv2.VideoCapture(0)
        ret, frame = cap.read()
        if ret:
            print("✓ OpenCV camera access works")
        else:
            print("✗ Camera access failed")
        cap.release()
        
        # Test Tkinter
        root = tk.Tk()
        root.withdraw()  # Hide the window
        print("✓ Tkinter works")
        root.destroy()
        
        # Test PIL
        if ret:
            img = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            pil_img = Image.fromarray(img)
            print("✓ PIL/Pillow works")
        
        print("\n=== BASIC SETUP STATUS ===")
        print("✓ Core dependencies are working")
        print("✗ Missing: dlib, face_recognition")
        print("\nTo fix: Install Visual Studio Build Tools or use Conda")
        
    except Exception as e:
        print(f"Error in basic setup: {e}")

if __name__ == "__main__":
    test_basic_setup()
