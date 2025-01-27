
IMAGES_TRAIN_DIR="data/images/train"
IMAGES_VAL_DIR="data/images/val"
LABELS_TRAIN_DIR="data/labels/train"
LABELS_VAL_DIR="data/labels/val"
LOG_FILE="logs/move_train_to_val.log"

# Create the val directories if they don't exist
mkdir -p "$IMAGES_VAL_DIR"
mkdir -p "$LABELS_VAL_DIR"
mkdir -p "logs" # also create the log-dir



# Clear or create the log file
echo "" > "$LOG_FILE"

# Find all .jpg files in the train directory
IMAGE_FILES=("$IMAGES_TRAIN_DIR"/*)

# Calculate 20% of the total files
TOTAL_FILES=${#IMAGE_FILES[@]}
MOVE_COUNT=$((TOTAL_FILES / 5))

# Shuffle the files and select the first MOVE_COUNT files
SELECTED_FILES=($(shuf -e "${IMAGE_FILES[@]}" | head -n $MOVE_COUNT))

# Display the selected files and ask for confirmation
echo "The following files will be moved to the val directory:" >> "$LOG_FILE"
for IMAGE_PATH in "${SELECTED_FILES[@]}"; do
    IMAGE_NAME=$(basename "$IMAGE_PATH" .jpg)
    echo "Image: $IMAGE_PATH" | tee -a "$LOG_FILE"
    if [ -f "$LABELS_TRAIN_DIR/$IMAGE_NAME.txt" ]; then
        echo "Label: $LABELS_TRAIN_DIR/$IMAGE_NAME.txt" | tee -a "$LOG_FILE"
    else
        echo "Warning: Label file for $IMAGE_NAME.jpg not found." | tee -a "$LOG_FILE"
    fi
done

read -p "Do you want to proceed with moving these files? (yes/no): " CONFIRMATION
if [ "$CONFIRMATION" != "yes" ]; then
    echo "Operation canceled by user." | tee -a "$LOG_FILE"
    exit 1
fi

# Move the selected files and their corresponding label files
for IMAGE_PATH in "${SELECTED_FILES[@]}"; do
    # Get the base name of the image file (without extension)
    IMAGE_NAME=$(basename "$IMAGE_PATH" .jpg)

    # Define the corresponding label file path
    LABEL_PATH="$LABELS_TRAIN_DIR/$IMAGE_NAME.txt"

    # Move the image file to the val directory
    mv "$IMAGE_PATH" "$IMAGES_VAL_DIR/"
    echo "Moved image: $IMAGE_PATH -> $IMAGES_VAL_DIR/" >> "$LOG_FILE"

    # Move the corresponding label file if it exists
    if [ -f "$LABEL_PATH" ]; then
        mv "$LABEL_PATH" "$LABELS_VAL_DIR/"
        echo "Moved label: $LABEL_PATH -> $LABELS_VAL_DIR/" >> "$LOG_FILE"
    else
        echo "Warning: Label file for $IMAGE_NAME.jpg not found." >> "$LOG_FILE"
    fi
done

# Inform the user about the result
echo "$MOVE_COUNT files have been moved from train to val. Check $LOG_FILE for details."


