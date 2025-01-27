import os
import time

from ultralytics import YOLO
import cv2
import numpy as np

VIDEOS_DIR = os.path.join('.', 'videos')

video_path = os.path.join(VIDEOS_DIR, 'RemisInMotion_vFlip.mp4')
video_path_out = 'RemisInMotion_out.mp4'.format(video_path)

cap = cv2.VideoCapture(video_path)

# Überprüfe, ob das Video korrekt geöffnet wurde
if not cap.isOpened():
    print("Fehler beim Öffnen des Videos.")
    exit()

ret, frame = cap.read()

# Überprüfe, ob ein Frame erfolgreich geladen wurde
if not ret or frame is None:
    print("Fehler beim Laden des ersten Frames.")
    exit()

H, W, _ = frame.shape
out = cv2.VideoWriter(video_path_out, cv2.VideoWriter_fourcc(*'MP4V'), int(cap.get(cv2.CAP_PROP_FPS)), (W, H))

model_path = os.path.join('.', 'models', 'alpaca_detector.pt')

# Lade das Modell
model = YOLO(model_path)  # Laden des benutzerdefinierten Modells

threshold = 0.5

class_name_dict = {0: 'Hydraulik-Presse'}

while ret:
    # Modell auf das Frame anwenden
    results = model(frame)[0]

    # Ergebnisse der Objekterkennung durchgehen
    for result in results.boxes.data.tolist():
        x1, y1, x2, y2, score, class_id = result

        # Nur Ergebnisse über dem Schwellenwert weiterverarbeiten
        if score > threshold:
            cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 4)
            cv2.putText(frame, results.names[int(class_id)].upper(), (int(x1), int(y1 - 10)),
                        cv2.FONT_HERSHEY_SIMPLEX, 1.3, (0, 255, 0), 3, cv2.LINE_AA)

    # Das bearbeitete Frame ins Ausgabedateiformat schreiben
    out.write(frame)

    # Nächstes Frame einlesen
    ret, frame = cap.read()

# Freigeben der Ressourcen
cap.release()
out.release()
cv2.destroyAllWindows()