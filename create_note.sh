#!/bin/bash

# Set variables
generate_filename_path="$PWD/generate_filename.js"
node_path="path/to/node/binary"
note_template_path="$PWD/note_template.txt"
note_folder="note_folder_name"
note_title="note_title"
note_body="note_body"
note_folder_path="~/Library/Application\ Support/Boostnote/Storage/"

# Generate filename
uuid=$("$node_path" "$generate_filename_path")
filename=$uuid.cson

# Get note template
note=$(<"$note_template_path")

# Get current timestamp
timestamp=$(date +"%Y-%m-%dT%H:%M:%SZ")

# Replace values in note template with defined global variables
note=$(echo "$note" | sed "s/<note_title>/$note_title/g")
note=$(echo "$note" | sed "s/<note_body>/$note_body/g")
note=$(echo "$note" | sed "s/<created_at>/$timestamp/g")
note=$(echo "$note" | sed "s/<updated_at>/$timestamp/g")
note=$(echo "$note" | sed "s/<note_folder>/$note_folder/g")

# Write file
echo "$note" >> "$note_folder_path"/notes/"$filename"

# Basic check note file exists
if [ -f "$note_folder_path"/notes/"$filename" ]; then
    echo "Note generated"
fi
