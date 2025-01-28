#!bin/bash

#Made by LizardKing on 2025.01.28
#This script takes care of the raspberry pi cam and takes video and saves them with appropriate naming scheme
#Promt user to ask how to name the vid

#################################################################################
#			activate the script with this command			                    #
# bash takeVideo.sh                                                             #
#################################################################################
default_name="video.mp4"
vid_lenght=60 #in seconds


RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

path="/home/Videos/REMIS-AI/"
echo -e "Data will be saved in ${RED}$path${NC}"
mkdir -v -p $path
user_input=""

echo "Please specify the filename:"
read user_input
if [ "$user_input" = "" ]; then 
    file="${default_name}"    
else
    file="$user_input"
fi
output_path="$path/$file$.mp4" 
echo "The video will be saved in the folder ${RED} \"${output_path}\"${NC}"


    libcamera-vid --preview=0,0,640,640 -t $vid_lenght --vflip=1 -o= "$output_path"

    # Show a message about the saved photo
    echo "Photo saved as ${GREEN}${output_path}${NC}"
done
