#!/usr/bin/bash
#Prompts the user to enter the assignment name, then the new input will replace the current name in config/config.env on the ASSIGNMENT
#check if the file config/config.env exists
read -p "Enter name of the directory you created: " yourname
app_dir="submission_reminder_$yourname"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FULL_APP_DIR="$SCRIPT_DIR/$app_dir"
echo "$FULL_APP_DIR"
cd $FULL_APP_DIR

if [[ ! -d "$FULL_APP_DIR" ]]; then
    echo "Error! App's main directory does not exist"
    exit 1
fi

if [  ! -f "$FULL_APP_DIR/config/config.env"  ];then
        echo "Error! File does not exist"
        exit 1
fi

#asking for the user input on the new assignment
read -p "Enter name of the assignment: " new_assignment
if [[ -z "$new_assignment" ]]; then
    echo "Error! New assignment name cannot be empty"
    exit 1
fi

#replace user input with the current name in config/config.env in row2
escaped_assignment=$(printf '%s\n' "$assignment" | sed 's/[\/&]/\\&/g')
sed -i "s/ASSIGNMENT=\".*\"/ASSIGNMENT=\"$new_assignment\"/" config/config.env
echo "Asignment updated successfully to: $new_assignment"

#rerun the startup.sh to check the changes in assignment and submission status
if [[ ! -f startup.sh ]]; then
    echo "Error! Startup.sh file cannot be found and cannot rerun the app"
    exit 1
fi

./startup.sh