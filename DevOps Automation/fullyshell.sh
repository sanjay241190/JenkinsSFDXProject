#!/bin/bash

# Check if branch name and date are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <branch_name> <date>"
    exit 1
fi

BRANCH_NAME=$1
DATE=$2

# Switch to the branch (if needed)
# git checkout $BRANCH_NAME

# Get the commit hash for the given date
COMMIT_HASH=$(git log --before="$DATE" --format=%H -n 1)

# List all files added, modified, or deleted since the given date and print on the console
git diff --name-status $COMMIT_HASH HEAD | while read -r status filename; do
    # Get the commit date for the file
    file_date=$(git log -1 --format=%cd -- $filename)

    # Print file status, file name, and file date on the console
    echo "$filename"
done > modified.txt

echo "Printed the File Changed after $DATE to FileChanges.txt"

# Compare modified.txt with commoncomponents.csv and mark duplicates
while IFS= read -r line; do
    if grep -qFx "$line" commoncomponents.csv; then
        echo "--- $line"
    fi
done < modified.txt > marked_modified.txt

echo "Marked duplicates in modified.txt and saved as marked_modified.txt"
