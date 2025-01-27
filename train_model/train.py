from ultralytics import YOLO

# Load a model
model = YOLO("yolov8n.yaml")

# Train the model
results = model.train(
    data="/home/RemisAI/repos/train_model/yolo/config.yaml",  # path to dataset YAML
    epochs=300,  # number of training epochs
    task="detect",
    # imgsz=640,  # training image size
    # device="cpu",  # device to run on, i.e. device=0 or device=0,1,2,3 or device=cpu
)
