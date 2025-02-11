# REMIS-AI

A Raspberry Pi-based machine assembly verification system that uses image recognition to ensure all parts are correctly installed for safe operation. The system captures images, utilizes machine learning to check alignment and part presence, and triggers alerts when problems are detected.

The project leverages YOLOv8, an advanced object detection model, for accurate and efficient verification.

![cad_assembly_01](https://github.com/user-attachments/assets/1f9701c1-089f-4af0-98e1-3c9f1d06a616)

---

## Hardware

Below is the list of hardware used in the project. Many components, such as the display, are optional. If alternative hardware is used, the scripts will need to be adapted accordingly:

- **Raspberry Pi 5** (8 GB RAM)
- **Cooling Fan**
- **64 GB SD Card**
- **Raspberry Pi Camera 3** (Regular Version)
- **OLED Display 2.7''** (Joy-IT, optional)
- **3D-printed PLA Casing** (PART file avalable, optional)

---

## Installation

This guide assumes you have installed Raspberry Pi OS. The official Raspberry Pi OS can be downloaded from the following source:

[Raspberry Pi OS Official Download](https://www.raspberrypi.org/software/)

After connecting your Raspberry Pi to the internet, run the following commands. It is highly recommended to perform this setup on a fresh installation to avoid interference from existing configurations.

### 1. Update and Upgrade the System

Start by updating and upgrading the system packages:

```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Create a Python Virtual Environment

Set up a virtual environment to isolate project dependencies:

```bash
sudo apt install python3-venv -y
mkdir -p ~/envs/
cd ~/envs/
python3 -m venv remis-ai
source ~/envs/remis-ai/bin/activate
which python
```

### 3. Install YOLO and other libaries in the virtual enviorment

Install the required YOLO dependencies and set up the YOLOv8 model:

```bash
bash ~/repos/REMUS-AI/misc/setup/install_venv.sh
pip install --upgrade pip
pip install ultralytics picamera
```

### 4. Clone the Repository

Clone this repository to your Raspberry Pi:

```bash
mkdir -p ~/repos/
cd ~/repos/
git clone https://github.com/LizardKing420/REMIS-AI.git
cd REMIS-AI
```

---

## Directory Structure

Ensure your project directory is structured as follows for YOLO to work correctly:

```
datasets/
    data/
        images/
            train/
                pic1.jpg
                pic2.jpg
                ...
            val/
                pic3.jpg
                ...
        labels/
            train/
                pic1.txt
                pic2.txt
                ...
            val/
                pic3.txt
                ...
    check_data.sh
    move_train_to_val.sh
    tmp/
        ...
    rawdata/
        ...
```

---

## Usage

### 1. Checking Data
Run the `check_data.sh` script to detect images without corresponding annotations:

```bash
cd ./datasets/
bash check_data.sh
```

### 2. Splitting Data
Use the `move_train_to_val.sh` script to move 20% of training data to the validation set:

```bash
cd ./datasets/
bash move_train_to_val.sh
```

### 3. Activate the Virtual Environment
Activate the virtual environment with the following command:

```bash
source venv/bin/activate
``` 

### 4. Training the model
This assumes the user has annoted the data, and put it in the `./datasets/data/` folders as explained in the section `Directory Structure` above

Run the `train.sh` script to run the nano v8 modell of the neural network (the script is set to run the modell on 500 cycles, this can be eassily modified):

```bash
cd ./train_model/
python3 train.py
```

---

## Future Improvements

- Add support for additional hardware configurations.
- Optimize model performance on Raspberry Pi hardware.
