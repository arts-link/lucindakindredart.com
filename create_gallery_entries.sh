#!/bin/bash

# Check if target directory is specified
if [ -z "$1" ]; then
    echo "Usage: ./create_gallery_entries.sh /path/to/target-directory"
    exit 1
fi

TARGET_DIR="$1"
CSV_FILE="cindy-website.csv"
echo "Target directory is: $TARGET_DIR"

# basedir within content
BASE_DIR="/gallery"

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory does not exist: $TARGET_DIR"
    exit 1
fi

# Check if the CSV file exists
if [ ! -f "$CSV_FILE" ]; then
    echo "CSV file not found: $CSV_FILE"
    exit 1
fi

# Loop through each file in the target directory
while IFS=, read -r csv_filename title dim; do
    # Skip header row or empty lines
    if [[ "$csv_filename" == "filename" ]] || [[ -z "$csv_filename" ]]; then
        continue
    fi

    # Replace .jpeg with .webp for filename matching
    csv_filename="${csv_filename%.jpeg}.webp"
    file="$TARGET_DIR/$csv_filename"

    # Skip if the file doesn't exist with .webp extension
    if [ ! -f "$file" ]; then
        echo "File not found: $file, skipping."
        continue
    fi

    # Extract the base name of the file (without extension)
    filename=$(basename "$file")
    name="${filename%.*}"

    # Sanitize the name: replace spaces with underscores, "&" with "and", and remove non-alphanumeric characters except "-"
    sanitized_name=$(echo "$name" | sed -e 's/ /_/g' -e 's/&/and/g' -e 's/[^a-zA-Z0-9_-]//g')

    # Clean up any newline characters in dim
    dim=$(echo "$dim" | tr -d '\n' | sed -e 's/\r//g')
    # Set the environment variables
    export HUGO_TITLE="$title"
    export HUGO_DIMENSIONS="$dim"

    # Output debug information
    echo "Processing file: $file"
    echo "Sanitized name: $sanitized_name"
    echo "Title: $HUGO_TITLE"
    echo "Dimensions: $HUGO_DIMENSIONS"
    echo "Creating Hugo content entry: content$BASE_DIR/$sanitized_name/index.md"

    # Create the new Hugo content entry
    hugo new "content$BASE_DIR/$sanitized_name/index.md"

    # Check if the Hugo command succeeded
    if [ $? -ne 0 ]; then
        echo "Failed to create Hugo content entry for $sanitized_name"
        continue
    fi

    # Copy the image file into the new directory
    echo "Copying $file to content$BASE_DIR/$sanitized_name/"
    cp "$file" "content$BASE_DIR/$sanitized_name/"

    echo "Created gallery entry for $sanitized_name and copied image file."

    # Clear environment variables after use
    unset HUGO_TITLE HUGO_DIMENSIONS
done < "$CSV_FILE"