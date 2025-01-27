import os
import time

from ultralytics import YOLO
import cv2
import numpy as np

VIDEOS_DIR = os.path.join('.', '/home/RemisAI/PythonCode')
print(f"Videos-Dir Ausgabe: {VIDEOS_DIR}")
video_path = os.path.join(VIDEOS_DIR, 'RemisInMotion_vFlip.mp4')
video_path_out = 'RemisInMotion_out.mp4'.format(video_path)
 
cap = cv2.VideoCapture(video_path)
print(cap)
ret, frame = cap.read()
H, W, _ = frame.shape
out = cv2.VideoWriter(video_path_out, cv2.VideoWriter_fourcc(*'MP4V'), int(cap.get(cv2.CAP_PROP_FPS)), (W, H))

#/home/RemisAI/PythonCode/runs/detect/train3/weights
model_path = os.path.join('.', '/home', 'RemisAI', 'PythonCode', 'runs', 'detect', 'train3', 'weights', 'last.pt')

#Load a model
model = YOLO(model_path) #load a custom model

threshold = 0.5

#class_name_dict = {0: 'Hydraulik-Presse'}

while ret:

    results = model(frame)[0]

    for result in results.boxes.data.tolist():
        x1, y1, x2, y2, score, class_id = result

        if score > threshold:
            cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 4)
            cv2.putText(frame, results.names[int(class_id)].upper(), (int(x1), int(y1 - 10)),
                        cv2.FONT_HERSHEY_SIMPLEX, 1.3, (0, 255, 0), 3, cv2.LINE_AA)

    out.write(frame)
    ret, frame = cap.read()

cap.release()
out.release()
cv2.destroyAllWindows()
