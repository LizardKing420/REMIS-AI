from picamera2 import Picamera2, Preview
from libcamera import Transform
import os

directory = "/home/RemisAI/Bilder/Rohbilder/"


picam2 = Picamera2()

# Konfiguration für Standbild (Foto)
picam2.configure(picam2.create_still_configuration(main={"size":(1920,1080)}, lores={"size": (640,480)}))

print("Hey faggot this are the camera settings:")
print(picam2.preview_configuration)
print()

# Kameraeinstellungen vornehmen
    # picam2.set_controls(
    #     exposure_mode='auto',
    #     awb_mode='auto',  # Weißabgleich automatisch
    #     iso=400,  # ISO-Wert für gute Belichtung
    #     sharpness=1.5,  # Etwas Schärfe hinzufügen
    #     contrast=1.0,  # Normale Kontrasteinstellung
    #     saturation=1.0  # Normale Sättigung
    # )

    # Standbild aufnehmen und speichern


#Ask the user what the file will be callled :
file = input("Hey faggot name the files:")


    
#Make directory
if not os.path.exists(directory):
    os.makedirs(directory)
    print(f"Directory {directory} created.")
else:
    print(f"Directory {directory} already exists.")
    
#loop for taking photos
i = 0

while True:
    picam2.start_preview(Preview.QTGL, transform= Transform(vflip=True))
    file_path = os.path.join(directory,f"{file}_{str.zfill(str(i),3)}.jpg")
    picam2.start_and_capture_file(file_path)
    picam2.close()
    
    i = i+1

    