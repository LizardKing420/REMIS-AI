import keyboard
import KameraEinstellungen
from picamera2 import Picamera2, Preview

picam2 = Picamera2()

for i in range(2):
    def on_hotkey():
        print("Hotkey gedrückt!")

        keyboard.add_hotkey('ctrl+Enter',on_hotkey)
    
        #Bei Betätigung des Hotkeys:
        picam2.start_and_capture_file(f"/home/RemisAI/Bilder/Rohbilder/Bild_{i}.jpg")
        picam2.close()


    keyboard.wait('esc')

