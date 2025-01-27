#!/bin/bash

# Define directories
IMAGES_DIR="images"
LABELS_DIR="labels"
LOG_FILE="check_labels.log"

# Clear the log file if it exists
echo "" > "$LOG_FILE"

# Check if the -r flag is passed
REMOVE_FILES=false
if [ "$1" == "-r" ]; then
    REMOVE_FILES=true
fi

# Iterate through all .jpg files in the images directory
for IMAGE_PATH in "$IMAGES_DIR"/*.jpg; do
    # Get the base name of the image file (without extension)
    IMAGE_NAME=$(basename "$IMAGE_PATH" .jpg)

    # Check if a corresponding .txt file exists in the labels directory
    if [ ! -f "$LABELS_DIR/$IMAGE_NAME.txt" ]; then
        # Log the absolute path of the unmatched image
        echo "$(realpath "$IMAGE_PATH")" >> "$LOG_FILE"

        # Remove the image if the -r flag is set
        if [ "$REMOVE_FILES" = true ]; then
            rm "$IMAGE_PATH"
        fi
    fi
done

# Inform the user about the result
echo "Process completed. Check $LOG_FILE for unmatched images."

