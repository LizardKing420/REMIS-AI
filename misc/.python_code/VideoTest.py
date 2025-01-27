from picamera2 import Picamera2, Preview
from time import sleep
from libcamera import Transform

picam2 = Picamera2()

picam2.start_preview(Preview.QTGL, transform= Transform(vflip=True))
picam2.start_and_record_video("Presse_Unterlagepraetzen_Werkstuech_Pressstuech_video_120s.mp4", duration=120, show_preview=True)
picam2.close
