#!/bin/bash

# Check if target directory is specified
if [ -z "$1" ]; then
    echo "Usage: ./create_gallery_entries.sh /path/to/target-directory"
    exit 1
fi

TARGET_DIR="$1"
echo "Target directory is: $TARGET_DIR"

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory does not exist: $TARGET_DIR"
    exit 1
fi

# Loop through each file in the target directory
for file in "$TARGET_DIR"/*; do
    # Skip if it's not a file
    if [ ! -f "$file" ]; then
        echo "$file is not a file, skipping."
        continue
    fi

    # Extract the base name of the file (without extension)
    filename=$(basename "$file")
    name="${filename%.*}"

    # Sanitize the name: replace spaces with underscores, "&" with "and", and remove non-alphanumeric characters except "-"
    sanitized_name=$(echo "$name" | sed -e 's/ /_/g' -e 's/&/and/g' -e 's/[^a-zA-Z0-9_-]//g')

    # Output debug information
    echo "Processing file: $file"
    echo "Sanitized name: $sanitized_name"
    echo "Creating Hugo content entry: content/gallery/$sanitized_name/index.md"

    # Create the new Hugo content entry
    hugo new "content/gallery/$sanitized_name/index.md"

    # Check if the Hugo command succeeded
    if [ $? -ne 0 ]; then
        echo "Failed to create Hugo content entry for $sanitized_name"
        continue
    fi

    # Copy the image file into the new directory
    echo "Copying $file to content/gallery/$sanitized_name/"
    cp "$file" "content/gallery/$sanitized_name/"

    echo "Created gallery entry for $sanitized_name and copied image file."
done