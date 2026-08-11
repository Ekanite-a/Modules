#!/bin/bash

for folder in *; do
    [[ -d "$folder" ]] || continue

    output_file="${folder}.lua"
    > "$output_file"

    return_table="return {"

    for file in "$folder"/*.url; do
        [[ -e "$file" ]] || continue

        filename=$(basename "$file" .url)

        url=$(cat "$file")

        {
            echo "local function ${filename}()"
            echo ""
            curl -sL "$url"
            echo ""
            echo "end"
        } >> "$output_file"

        return_table+="${filename}=${filename}(),"
    done
    for file in "$folder"/*.lua; do
        [[ -e "$file" ]] || continue

        filename=$(basename "$file" .lua)

        content=$(cat "$file")

        {
            echo "local function ${filename}()"
            echo ""
            echo "$content"
            echo ""
            echo "end"
        } >> "$output_file"

        return_table+="${filename}=${filename}(),"
    done

    return_table+="}"
    echo "$return_table" >> "$output_file"
done
