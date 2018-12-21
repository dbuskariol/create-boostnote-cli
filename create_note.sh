#!/bin/bash

# Set variables
generate_filename_path="$PWD/generate_filename.js"
note_template_path="$PWD/note_template.txt"

node_path="path/to/node/binary"
note_folder="note_folder_id"
note_title="title"
note_body="body"
note_storage_path="path/to/boostnote/storage"

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
echo "$note" >> "$note_storage_path"/notes/"$filename"

# Basic check note file exists
if [ -f "$note_storage_path"/notes/"$filename" ]; then
    echo "Note created: [$note_title](:note:$uuid)"
else
  echo "Unable to create note in $note_storage_path/notes/"
fi
