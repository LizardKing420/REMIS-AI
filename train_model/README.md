# **How to Train the Model**

## **Prerequisites**
- **Data Setup:** Ensure the dataset is properly configured and ready for use.
- **Epochs:** Verify the number of epochs (250-300 recommended for optimal results).
- **Model Selection:** Confirm the model specified in the script (default: YOLOv8-nano).
- **Configuration:** Ensure the configuration file is correctly set up (`REMIS-AI/train_model/yolo/config.yaml`).

## **Execution Environment**
- **Raspberry Pi:** Training can be performed directly on the Raspberry Pi (extremely slow but feasible).
- **External Hardware:** For faster performance, use external hardware. Note: Installation scripts are tailored for Debian-based systems and may require adjustments for other environments.

## **Steps to Run**
1. **Activate the Virtual Environment:**
   ```bash
   source venv/bin/activate
   ```
2. **Execute the Training Script:**
   ```bash
   python3 ~/repos/REMIS-AI/train_model/yolo/main.py
   ```

