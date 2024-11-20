#!/bin/bash

# Check if target directory is specified
if [ -z "$1" ]; then
    echo "Usage: ./create_gallery_entries.sh /path/to/target-directory"
    exit 1
fi

TARGET_DIR="$1"
CSV_FILE="cindy-website-inventory-clean.csv"
echo "Target directory is: $TARGET_DIR"

# basedir within content
BASE_DIR="gallery"

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
while IFS=, read -r csv_filename title dimensions series exhibited date_created buyer price; do
    # Skip header row or empty lines
    if [[ "$csv_filename" == "filename" ]] || [[ -z "$csv_filename" ]]; then
        echo "Skipping header row or empty line."
        continue
    fi

    # Replace .jpeg or .jpg with .webp for filename matching
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
    # Clean up any newline characters in dimensions
    title=$(echo "$title" | tr -d '\n' | sed -e 's/\r//g')
    dimensions=$(echo "$dimensions" | tr -d '\n' | sed -e 's/\r//g')
    series=$(echo "$series" | tr -d '\n' | sed -e 's/\r//g')
    exhibited=$(echo "$exhibited" | tr -d '\n' | sed -e 's/\r//g')
    date_created=$(echo "$date_created" | tr -d '\n' | sed -e 's/\r//g')
    buyer=$(echo "$buyer" | tr -d '\n' | sed -e 's/\r//g')
    price=$(echo "$price" | tr -d '\n' | sed -e 's/\r//g')

    # Set the environment variables
    export HUGO_IMAGE_NAME="$csv_filename"
    export HUGO_TITLE="$title"
    export HUGO_DIMENSIONS="$dimensions"
    export HUGO_SERIES="$series"
    export HUGO_EXHIBITED="$exhibited"
    export HUGO_DATE_CREATED="$date_created"
    export HUGO_BUYER="$buyer"
    export HUGO_PRICE="$price"
    export HUGO_FROM_CSV="true"

    # Output debug information
    echo "Processing file: $file"
    echo "HUGO_IMAGE_NAME: $csv_filename"
    echo "DIRECTORY NAME (sanity now): $sanitized_name"
    echo "HUGO_TITLE: $HUGO_TITLE"
    echo "HUGO_DIMENSIONS: $HUGO_DIMENSIONS"
    echo "HUGO_SERIES: $HUGO_SERIES"
    echo "HUGO_EXHIBITED: $HUGO_EXHIBITED"
    echo "HUGO_DATE_CREATED: $HUGO_DATE_CREATED"
    echo "HUGO_BUYER: $HUGO_BUYER"
    echo "HUGO_PRICE: $HUGO_PRICE"
    echo "Creating Hugo content entry: content$BASE_DIR/$sanitized_name/index.md"

    # Create the new Hugo content entry
    hugo new "$BASE_DIR/$sanitized_name" --kind gallery

    # Check if the Hugo command succeeded
    if [ $? -ne 0 ]; then
        echo "Failed to create Hugo content entry for $sanitized_name"
        continue
    fi

    # Copy the image file into the new directory
    echo "Copying $file to content/$BASE_DIR/$sanitized_name/"
    cp "$file" "content/$BASE_DIR/$sanitized_name/"

    echo "Created gallery entry for $sanitized_name and copied image file."
    echo "----------------------------------------"
    echo "----------------------------------------"
    echo "----------------------------------------"
    echo "----------------------------------------"
    echo ""
    echo ""
    echo ""

    # Clear environment variables after use
    unset HUGO_IMAGE_NAME HUGO_TITLE HUGO_DIMENSIONS HUGO_SERIES HUGO_EXHIBITED HUGO_DATE_CREATED HUGO_BUYER HUGO_PRICE HUGO_FROM_CSV
done < "$CSV_FILE"


echo "STARTING DIRECTORIES LOOP"
    echo "***************************"
    echo "***************************"
    echo "***************************"
    echo "***************************"
    echo ""
    echo ""
    echo ""

# Loop through the target directory directly (after CSV processing)
for file in "$TARGET_DIR"/*; do
    # Skip if it's not a file (e.g., a directory)
    if [ ! -f "$file" ]; then
        continue
    fi

    # Extract the base name of the file (without extension)
    filename=$(basename "$file")
    name="${filename%.*}"

    # Sanitize the name
    sanitized_name=$(echo "$name" | sed -e 's/ /_/g' -e 's/&/and/g' -e 's/[^a-zA-Z0-9_-]//g')

    # Check if the Hugo content already exists for this file
    if [ -d "content/$BASE_DIR/$sanitized_name" ]; then
        echo "Content already exists for $sanitized_name, skipping."
        continue
    fi

    # export HUGO_TITLE="$sanitized_name"
    export HUGO_IMAGE_NAME="$filename"

    # Create the new Hugo content entry using filename without extension
    echo "Creating Hugo content entry for $sanitized_name"
    hugo new "$BASE_DIR/$sanitized_name" --kind gallery

    # Check if the Hugo command succeeded
    if [ $? -ne 0 ]; then
        echo "Failed to create Hugo content entry for $sanitized_name"
        continue
    fi

    # Copy the image file into the new directory
    echo "Copying $file to content/$BASE_DIR/$sanitized_name/"
    cp "$file" "content/$BASE_DIR/$sanitized_name/"

    echo "Created gallery entry for $sanitized_name and copied image file."
    echo "***************************"
    echo "***************************"
    echo "***************************"
    echo "***************************"
    echo ""
    echo ""
    echo ""
    
    unset HUGO_TITLE HUGO_IMAGE_NAME
done