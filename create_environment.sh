#!/bin/bash

# Prompt for name
read -p "Enter your name: " username

# Create base directory
base_dir="submission_reminder_${username}"
mkdir -p "$base_dir"

# Create subdirectories
mkdir -p "$base_dir/app"
mkdir -p "$base_dir/modules"
mkdir -p "$base_dir/assets"
mkdir -p "$base_dir/config"

# Copy files
echo  "$base_dir/app/reminder.sh"
echo  "$base_dir/modules/functions.sh"
echo  "$base_dir/config/config.env"
echo  "$base_dir/assets/submissions.txt"  

# Create startup.sh
echo "#!/bin/bash" > "$base_dir/startup.sh"
echo "echo 'Starting reminder app...'" >> "$base_dir/startup.sh"
echo "bash app/reminder.sh" >> "$base_dir/startup.sh"

# config.env
cat <<EOL > "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

#reminder.sh
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
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}

# submissions.txt
cat <<EOL > "$main_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Angel, Shell Navigation, not submitted
Faith, shell Basics, submitted
Antony, Shell Navigation, not submitted
David, Git, not submitted
Alvin, Shell Basics, submitted

# Make all .sh files executable
find "$base_dir" -type f -name "*.sh" -exec chmod +x {} \;

echo "Environment setup complete in $base_dir"
