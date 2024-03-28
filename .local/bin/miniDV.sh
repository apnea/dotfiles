#!/bin/bash
# This script is licensed under the MIT License (https://morph.sh/mit-license)
# taken from https://morph.sh/posts/2023-11-04-minidv-workflow/

set -e
set -o pipefail

if ! [ "$1" ]; then
    echo "No arguments given! Exiting."
    exit 1
fi

set -u

TAPE_NAME="$1"
BASE_DIR="$HOME/minidv"

# make sure the general working directory is there
[ -d "${BASE_DIR}" ] || mkdir "${BASE_DIR}"
mkdir "${BASE_DIR}/to-convert"
mkdir "${BASE_DIR}/converted"

# create directory for this tape
if [[ -d "${BASE_DIR}/${TAPE_NAME}" ]]; then
    echo "Directory ${BASE_DIR}/${TAPE_NAME} exists!"
    echo "Aborting due to risk of losing data."
    echo "Please delete the directory before continuing."
    exit 1
else
    mkdir "${BASE_DIR}/${TAPE_NAME}"
    cd "${BASE_DIR}/${TAPE_NAME}"
fi

# Start dvgrab
sudo dvgrab --rewind --autosplit --format dv2 "${TAPE_NAME}"-

# Write list of files for ffmpeg to concatenate
rm -f list.txt && find . -name "${TAPE_NAME}*.avi" -exec echo "file '{}'" >> list.txt \;

# Concatenate all video files into one
ffmpeg -f concat -safe 0 -i list.txt -c copy "${TAPE_NAME}_concatenated.avi"

# move file to directory for HandBrake to convert
mv "${TAPE_NAME}_concatenated.avi" "${BASE_DIR}/to-convert"

