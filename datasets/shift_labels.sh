#!/bin/bash

# WARNING: Don't touch this if you don't know what you are doing!
# This script modifies every single .txt file in the `data/labels` directory.
# It was written to correct a constant mistake produced by CVAT.ai.
# CVAT starts labeling from 1 (e.g., 1: lab1; 2: lab2; 3: lab3; etc...),
# but YOLO requires the numbering to start from 0 (e.g., 0: lab1; 1: lab2; 2: lab3; etc...).

#Colors 
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Define the directories
LABELS_DIRS=("data/labels/train" "data/labels/val")
LOG_PATH="data/logs/"
LOG_FILE="${LOG_PATH}shift_labels.log"

# Ensure log directory exists
mkdir -p "$LOG_PATH"
echo "Label update log - $(date)" > "$LOG_FILE"

# Ask the user for the maximum label index
read -p "Enter the maximum label index used in the data: " max_label

# Function to process a single file
process_file() {
    local file_path="$1"
    echo "Processing: $file_path" >> "$LOG_FILE"
    while read -r line; do
        first_col=$(echo "$line" | awk '{print $1}')
        if [[ "$first_col" =~ ^[0-9]+$ ]] && (( first_col > 0 && first_col <= max_label )); then
            new_first_col=$((first_col - 1))
            modified_line=$(echo "$line" | sed -E "s/^$first_col /$new_first_col /")
            echo "$modified_line"
            echo "Updated: $line -> $modified_line" >> "$LOG_FILE"
        else
            echo "$line"
        fi
    done < "$file_path" > "${file_path}.tmp"
    mv "${file_path}.tmp" "$file_path"
}

# Process all .txt files in the label directories
for label_dir in "${LABELS_DIRS[@]}"; do
    for file_path in "$label_dir"/*.txt; do
        [ -e "$file_path" ] || continue  # Skip if no .txt files found
        process_file "$file_path"
    done
done

echo -e "All label files have been updated. Log saved to ${RED}${LOG_FILE}${NC}"
