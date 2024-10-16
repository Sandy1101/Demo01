#!/bin/bash

# Input string containing values separated by a delimiter (e.g., comma)
input_string="$modifiedfiles"

# Define the delimiter
delimiter=","

# Split the input string into an array using the delimiter
IFS="$delimiter" read -ra filenames <<< "$input_string"

# Create an associative array to store unique values
declare -A unique_values

exclude1=".github"
exclude2="."
exclude3="Scripts"

# Iterate through the values to copy unique ones into the associative array
for filename in "${filenames[@]}"; do
	folder_name="$(dirname "$filename")"
	#echo "$folder_name"
    # Use the value as a key in the associative array to ensure uniqueness
	base_dir=$(echo "$folder_name" | awk -F'/' '{print $1}')	
	#echo "$base_dir"
	if  [[ "$base_dir" == "$exclude1" ]] || [[ "$base_dir" == "$exclude2" ]] || [[ "$base_dir" == "$exclude3" ]]; then		
		continue
	else
		unique_values["$base_dir"]=0
	fi
done

# Convert the associative array keys (unique values) into a regular indexed array
if [ "${#unique_values[@]}" != 0 ]; then
	unique_array=("${!unique_values[@]}")

# Print the unique values (optional)
	for value in "${unique_array[@]}"; do
		echo "$value"
	done
else
	echo "No deployment needed"
fi
