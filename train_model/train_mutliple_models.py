from ultralytics import YOLO
import datetime

# Load a model
model = YOLO("yolov8n.yaml")

# Train the model
results = model.train(
    data="/home/RemisAI/repos/train_model/config.yaml",  # path to dataset YAML
    epochs=300,  # number of training epochs
    task="detect",
    save=True,
    save_period=50, #epochs/save_period is the number of models produced
    project="REMIS_AI",
    name=f"yolov8n_{datetime.date.today().strftime("%Y_%m_%d_%H_%M_%S")}", #model directory: yolov8n_YYYY_MM_DD_HH_MM_SS/...
    # imgsz=640,  # training image size
    # device="cpu",  # device to run on, i.e. device=0 or device=0,1,2,3 or device=cpu
)
