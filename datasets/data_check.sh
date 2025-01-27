#!/bin/bash

# Define directories
IMAGES_DIR="data/images"
LABELS_DIR="data/labels"
LOG_DIR="logs"
LOG_FILE="check_labels.log"
DATA_FLAG=true #data test passed?

# Make log directory if it doesnt exist
mkdir -p "$LOG_DIR"

# Edit the log path
LOG_FILE="${LOG_DIR}/${LOG_FILE}"

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
        DATA_FLAG=false #data is not OK
        echo"Warning: File $IMAGE_PATH has no label!"
        # Log the absolute path of the unmatched image
        echo "$(realpath "$IMAGE_PATH")" >> "$LOG_FILE"

        # Remove the image if the -r flag is set
        if [ "$REMOVE_FILES" = true ]; then
            rm "$IMAGE_PATH"
        fi
    fi
done

if [ "$DATA_FLAG" = false ]; then
    echo "Data test failed!"
    echo "Run the follwing line to see the files which failed the test:"
    echo "\e[1;32m] cat $LOG_FILE \e[0m]" #Display the command in green 

else
    echo "Data test passed!"  
fi

# Inform the user about the result
echo "Process completed. Check $LOG_FILE for unmatched images."

