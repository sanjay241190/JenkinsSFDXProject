#!/bin/bash

# Check if branch name and date are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <branch_name> <date>"
    exit 1
fi

BRANCH_NAME=$1
DATE=$2

# Switch to the branch
git checkout $BRANCH_NAME

# Get the commit hash for the given date
COMMIT_HASH=$(git log --before="$DATE" --format=%H -n 1)

# List all files added, modified, or deleted since the given date and write to a text file
git diff --name-status $COMMIT_HASH HEAD | while read -r line; do
    # Extract file status and file name from the line
    status=$(echo $line | awk '{print $1}')
    filename=$(echo $line | awk '{print $2}')

    # Get the commit date for the file
    file_date=$(git log -1 --format=%cd --date=iso -- $filename)

    # Print file status, file name, and file date
    echo "$status $filename $file_date"
done > changes_with_date.txt
    echo "$status $filename $file_date"
echo "Changes with dates written to changes_with_date.txt"
