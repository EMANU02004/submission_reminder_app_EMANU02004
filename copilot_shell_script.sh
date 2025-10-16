#!/bin/bash

# Define the main directory
main_dir="submission_reminder_community"

# Check if environment exists
if [ ! -d "$main_dir" ]; then
	    echo "Error: File does not exist."
	        exit 1
fi

# Ask for assignment name
echo "Please enter assignment name:"
read assignment_name

# Update config file
echo "assignment=$assignment_name" > "$main_dir/config/config_env"
echo "Assignment updated to: $assignment_name"

echo ""
echo "=== Checking submissions for: $assignment_name ==="

# Use grep to find students who have not submitted
echo "Students who haven't submitted:"
grep -i "$assignment_name" "$main_dir/assets/submissions.txt" | grep "not submitted" | while IFS=',' read -r student assignment status; do
    student_clean=$(echo "$student" | xargs)
    echo "$student_clean"
done

# Count total for this assignment
total_assignment=$(grep -i "$assignment_name" "$main_dir/assets/submissions.txt" | wc -l)
not_submitted=$(grep -i "$assignment_name" "$main_dir/assets/submissions.txt" | grep -i "not submitted" | wc -l)

echo ""
echo "=== SUMMARY ==="
echo "Total students with '$assignment_name': $total_assignment"
echo "Not submitted: $not_submitted"
echo "Submitted: $((total_assignment - not_submitted))"
