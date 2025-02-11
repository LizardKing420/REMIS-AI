#Small debugging program to test if a connection to the camera can be established.
from picamera import PiCamera
from datetime import datetime
import os

# Set the save folder path
save_folder = "/home/pi/Pictures/Captured_Images/"

# Create the directory if it doesn't exist
os.makedirs(save_folder, exist_ok=True)

# Generate timestamped filename
filename = datetime.now().strftime("%Y-%m-%d_%H-%M-%S") + ".jpg"
file_path = os.path.join(save_folder, filename)

# Capture and save image
with PiCamera() as camera:
    camera.resolution = (1024, 768)  # Set resolution
    camera.start_preview()
    # Camera warm-up time
    camera.capture(file_path)
    print(f"Image saved to: {file_path}")