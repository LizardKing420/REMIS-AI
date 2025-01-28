#!bin/bash

#Made by Ante Martic on 2025.01.09. 
#This script takes care of the raspberry pi cam and takes photos and saves them with appropriate naming scheme
#Promt user to ask which part is on the photo

#################################################################################
#			activete the script with this command			                    #
# bash takePhoto.sh                                                             #
#################################################################################
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo "---------------------------------------------------"
echo "Please write the name of the primary part on the series of photos. In a case of multiple objects on the photo series, write them after another."
read file 
path="/home/repos/RemisAI/datasets/raw_data"
echo -e "Data will be saved in ${RED}$path${NC}"
mkdir -v -p $path

user_input=""

# While loop that keeps asking for input until the user enters "done"
while true 
do
    echo "Please write the name of the next object on the series of photos, if all of the objects were allready named, type 'done' to finish the naming scheme:"
    read user_input
    if [ "$user_input" = "done" ]; then 
        echo "The files will be saved in the folder \"${path}\", with the files named as: \"${file}_000\", \"${file}_001\", \"${file}_002\", etc..."
        break  # Exit the loop
    fi
    file="${file}_$user_input"
done


photo_counter=0

while true; do
    # Show preview using libcamera-vid (a video preview without recording)
    libcamera-vid --preview=0,0,640,640 -t 0 --vflip=1 & 

    # Capture the process ID of libcamera-vid
    preview_pid=$!

    # Wait for user input
    read -n 1 -s -p "Press Enter to take a photo or 's' to stop: "

    # If the user presses 's', exit the loop
    if [[ "$REPLY" == "s" ]]; then
        kill $preview_pid
        echo "Exiting..."
        break
    fi

    # Stop the preview and capture the photo
    kill $preview_pid
    file_name_full="$path/$file$(printf "%03d" $photo_counter).jpg" 
    libcamera-jpeg -n -o "$file_name_full"  --vflip=1 --width=640 --height=640

    # Increment the photo counter
    photo_counter=$((photo_counter + 1))

    # Show a message about the saved photo
    echo "Photo saved as $file_name_full"
done
