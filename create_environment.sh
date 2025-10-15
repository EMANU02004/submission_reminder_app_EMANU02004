#!/usr/bin/bash

# Ask for the user's name
read -p "Enter your name: " yourname

parent_dir="submission_remainder_${yourname}"
mkdir -p "$parent_dir"

# Create the subdirectories
 mkdir -p "$main_dir/app"
 mkdir -p "$main_dir/modules"
 mkdir -p "$main_dir/assets"
 mkdir -p "$main_dir/config"

# config.env
 cat <<EOL > "$main_dir/config/config.env"
# This is the config file
 ASSIGNMENT="Shell Navigation"
 DAYS_REMAINING=2
 EOL

# reminder.sh
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

check_submissions $submissions_file

# functions.sh
cat <<EOL > "$main_dir/modules/functions.sh"
#!/usr/bin/env bash
# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"
	# Skip the header and iterate through the lines
	  while IFS=, read -r student assignment status; do
	             # Remove leading and trailing whitespace
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
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOL

# startup.sh
cat <<EOL > "$main_dir/startup.sh"
#!/usr/bin/env bash
# Startup script for submission reminder app

# Load functions
source ./modules/functions.sh

# Load configuration
source ./config/config.env

## Start reminder script
./app/reminder.sh

# Make the scripts executable
chmod +x "$main_dir/app/reminder.sh"
chmod +x "$main_dir/modules/functions.sh"
chmod +x "$main_dir/startup.sh"

echo "Environment setup complete!"
