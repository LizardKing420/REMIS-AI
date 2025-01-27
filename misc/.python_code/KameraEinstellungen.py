from picamera2 import Picamera2, Preview
from libcamera import Transform

# Kamera initialisieren
picam2 = Picamera2()

#Vertikal flippen
picam2.start_preview(Preview.QTGL, transform= Transform(vflip=True))

# Konfiguration für Standbild (Foto)
picam2.configure(picam2.create_still_configuration(main={"size":(1920,1080)}, lores={"size": (640,480)}))

# Kameraeinstellungen vornehmen
picam2.set_controls(
    exposure_mode='auto',
    awb_mode='auto',  # Weißabgleich automatisch
    iso=400,  # ISO-Wert für gute Belichtung
    sharpness=1.5,  # Etwas Schärfe hinzufügen
    contrast=1.0,  # Normale Kontrasteinstellung
    saturation=1.0  # Normale Sättigung
)

# Kamera starten
picam2.start()

# Standbild aufnehmen und speichern
picam2.capture_file("/Desktop/image.jpg")

# Kamera stoppen
picam2.stop()
