# The Data Directory

YOLO requires the data to be structured in directories as follows:
```
data/
    images/
        train/
            pic1.jpg
            pic2.jpg
        val/
            pic3.jpg
    labels/
        train/
            pic1.txt
            pic2.txt
        val/
            pic3.txt
```

## Check Data Script
This script detects images in the `images` directory that do not have corresponding annotations in the `labels` directory.

### How to Run:
Navigate to the `datasets` directory and execute the script:
```bash
cd ./datasets/
bash check_data.sh
```

## Move Train to Val Script
If all the data is initially located in the `train` directory, this script moves approximately 20% of the data from `train` to `val`. The corresponding annotation files in the `labels` directory are moved as well.

### How to Run:
Navigate to the `datasets` directory and execute the script:
```bash
cd ./datasets/
bash move_train_to_val.sh

