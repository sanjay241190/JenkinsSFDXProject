#!/bin/bash

# Check if the branch name and date argument are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <branch_name> <date>"
    exit 1
fi

# Get the branch name and date
branch_name=$1
date_to_check=$2

# Get the commit ID after the provided date on the specified branch
commit_id=$(git log --after="$date_to_check" --pretty=format:%H "$branch_name" | tail -n 1)

# Show the files changed in the specified commit with their change dates
git diff-tree --no-commit-id --name-status -r "$commit_id" | while read -r line; do
    file_status=$(echo "$line" | awk '{print $1}')
    file_name=$(echo "$line" | awk '{print $2}')
    file_change_date=$(git log --format="%ad" --date=short -1 -- "$file_name")
    echo "$file_status $file_name $file_change_date"
done
