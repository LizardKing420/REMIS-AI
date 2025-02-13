import time
from picamera2 import Picamera2

# Quick program for debugging, it tests the functionality of the webcam
def test_webcam():
    # Initialize the camera
    picam2 = Picamera2()

    try:
        # Configure the camera for preview
        preview_config = picam2.create_preview_configuration()
        picam2.configure(preview_config)

        # Start the camera
        picam2.start()
        print("Webcam is working! Press 'Ctrl+C' to exit.")

        while True:
            # Capture a frame
            frame = picam2.capture_array()

            # Here you could display the frame using a library like matplotlib or PIL
            # For simplicity, we'll just print the shape of the frame
            print(f"Frame shape: {frame.shape}")

            # Sleep for a short time to avoid overwhelming the CPU
            time.sleep(0.1)

    except KeyboardInterrupt:
        print("Exiting...")

    finally:
        # Stop the camera
        picam2.stop()

if __name__ == "__main__":
    test_webcam()