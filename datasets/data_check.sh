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

# Function to process subdirectories
process_directory() {
    local IMAGE_SUBDIR="$1"
    local LABEL_SUBDIR="$2"

    # Iterate through all .jpg files in the image subdirectory
    for IMAGE_PATH in "$IMAGE_SUBDIR"/*; do
        echo "Processing $IMAGE_PATH ..."
        # Get the base name of the image file (without extension)
        IMAGE_NAME=$(basename "$IMAGE_PATH" .jpg)

        # Check if a corresponding .txt file exists in the label subdirectory
        if [ ! -f "$LABEL_SUBDIR/$IMAGE_NAME.txt" ]; then
            # Log the absolute path of the unmatched image
            echo "$(realpath "$IMAGE_PATH")" >> "$LOG_FILE"

            # Remove the image if the -r flag is set
            if [ "$REMOVE_FILES" = true ]; then
                rm "$IMAGE_PATH"
            fi
        fi
    done
}

# Process the test and val subdirectories
process_directory "$IMAGES_DIR/train" "$LABELS_DIR/train"
process_directory "$IMAGES_DIR/val" "$LABELS_DIR/val"

if [ "$DATA_FLAG" = false ]; then
    echo -e "\033[1;31mData test failed! \033[0m"
    echo "Run the follwing line to see the files which failed the test:"
    echo -e "\033[0;31m cat $LOG_FILE \033[0m" #Display the command in green 

else
    echo -e "\033[1;32mData test passed!\033[0m"  
fi

# Inform the user about the result
echo "Process completed. Log-file saved at: $LOG_FILE ."

