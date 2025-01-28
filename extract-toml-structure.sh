#!/bin/bash

input_file=$(zenity --file-selection --title="Select the .toml file" --file-filter="*.toml")

# Check if the user selected a file
if [[ -z "$input_file" ]]; then
    echo "No file selected. Exiting."
    exit 1
fi

# Get the directory and filename of the selected file
input_dir=$(dirname "$input_file")
input_name=$(basename "$input_file" .toml)

# Set the output file path
output_file="${input_dir}/${input_name}_copy.toml"

# Extract structure and write to output file
awk -F'=' '{print $1"="}' "$input_file" > "$output_file"

# Notify the user
zenity --info --text="Structure copied to $output_file."

echo "Structure copied to $output_file."

