<<<<<<< HEAD
#!/usr/bin/bash

#When the script runs, it should prompt the user for their name and create a directory named submission_reminder_{yourName}, replacing {yourName} With the input.

read -p "Enter your name: " yourname
#make the directory called submission_remainder_{yourname} as well as the subdirectories with their contents

parent_dir="submission_remainder_${yourname}"
mkdir -p "$parent_dir"

#create subdirectories
mkdir -p "$parent_dir/app"
mkdir -p "$parent_dir/modules"
mkdir -p "$parent_dir/assets"
mkdir -p "$parent_dir/config"

#creating the files and their contents

app="$parent_dir/app"
modules="$parent_dir/modules"
assets="$parent_dir/assets"
config="$parent_dir/config"

#create config.env and its content
cat > "$config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

#create reminder.sh and its content
cat > "$app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions
EOF

#create functions.sh and its contents
cat > "$modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"
=======
#!/usr/bin/env bash

# Ask for the user's name
echo "Enter your name:"
read yourName

# Create the main directory
main_dir="submission_reminder_${yourName}"
mkdir -p "$main_dir"

# Create the subdirectories
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/assets"
mkdir -p "$main_dir/config"

# Create and populate the files

# config.env
cat <<EOL > "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

# reminder.sh
cat <<EOL > "$main_dir/app/reminder.sh"
#!/usr/bin/env bash

# Source environment variables and helper functions
source ../config/config.env
source ../modules/functions.sh

# Path to the submissions file
submissions_file="../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions \$submissions_file
EOL

# functions.sh
cat <<EOL > "$main_dir/modules/functions.sh"
#!/usr/bin/env bash
# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"
>>>>>>> 51f2d398c07168388aad2dba3f983d5f2699a99e

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
<<<<<<< HEAD
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

#create submissions.txt and its contents
cat > "$assets/submissions.txt" << 'EOF' 
student, assignment, submission status
=======
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOL

# submissions.txt
cat <<EOL > "$main_dir/assets/submissions.txt"
>>>>>>> 51f2d398c07168388aad2dba3f983d5f2699a99e
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
<<<<<<< HEAD
Angel, Shell Navigation, not submitted
Faith, shell Basics, submitted
Antony, Shell Navigation, not submitted
David, Git, not submitted
Alvin, Shell Basics, submitted
EOF

cat > "$parent_dir/startup.sh" << 'EOF'
#!/usr/bin/bash
#chck if file exists in the directory. we use config because the app cannot run without config.env file even if the script is available

if [  ! -f "$config/config.env"  ]; then 
    echo "Error occurred. Run this script from submission_remainder dir"
    exi 1
fi
#Run the reminder.sh script
bash app/reminder.sh
EOF

#Give .sh files excecution permissions
chmod +x "$app"*.sh
chmod +x "$modules"*.sh
chmod +x startup.sh


echo "wow! Environment has been created successfully"
echo "To test the application run:" 
echo "cd $parent_dir && ./startup.sh"
=======
John, Shell Navigation, submitted
Jane, git, not submitted
Kevin, Shell Basics, not submitted
Faith, Git, submitted
Mary, Shell Navigation, not submitted
EOL

# startup.sh
cat <<EOL > "$main_dir/startup.sh"
#!/usr/bin/env bash
# Startup script for submission reminder app

# Load functions
source ./modules/functions.sh

# Load configuration
source ./config/config.env

# Start reminder script
./app/reminder.sh
EOL

# Make the scripts executable
chmod +x "$main_dir/app/reminder.sh"
chmod +x "$main_dir/modules/functions.sh"
chmod +x "$main_dir/startup.sh"

echo "Environment setup complete!"
>>>>>>> 51f2d398c07168388aad2dba3f983d5f2699a99e
