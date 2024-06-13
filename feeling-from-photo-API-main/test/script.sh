#!/bin/bash

API_URL="http://172.17.0.2:5000/detect-emotions"

echo
for image_file in *.jpg; do
  if [ -f "$image_file" ]; then
    image_path=$(realpath "$image_file")
    echo "Uploading: $image_file"
    curl -X POST -F "image_file=@$image_path" "$API_URL"
    echo
  fi
done
