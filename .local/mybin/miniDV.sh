#!/bin/bash
# This script is licensed under the MIT License (https://morph.sh/mit-license)
# taken from https://morph.sh/posts/2023-11-04-minidv-workflow/

set -e
set -o pipefail

if [ "$#" -lt 2 ]; then
    echo "Need 2 arguments: shooting day and tape name! Exiting."
    exit 1
fi

set -u

SHOOT_DAY="$1"
TAPE_NAME="$2"
PROJ_DIR="$HOME/dv/"
BASE_DIR=$PROJ_DIR$SHOOT_DAY

# do not work if no bas dir
if ! [[ -d "${PROJ_DIR}" ]]; then
	echo "No directory for project: \"${PROJ_DIR}\"! Please check path or create."
	echo "Exiting."
	exit 1
fi

echo $BASE_DIR

if [[ -d "${BASE_DIR}" ]]; then
	echo "Shoot day base directory exists: ${BASE_DIR}"
else
	echo "Creating shoot day base directory: ${BASE_DIR}..."
	mkdir ${BASE_DIR}
fi

# create directory for this tape
if [[ -d "${BASE_DIR}/${TAPE_NAME}" ]]; then
    echo "Tape directory ${BASE_DIR}/${TAPE_NAME} exists!"
    echo "Aborting due to risk of losing data."
    echo "Please delete the directory before continuing."
    exit 1
else
    echo "Creating ${BASE_DIR}/${TAPE_NAME}..."
    mkdir "${BASE_DIR}/${TAPE_NAME}"
    cd "${BASE_DIR}/${TAPE_NAME}"
fi

# Start dvgrab
sudo dvgrab --rewind -showstatus --format dv2 "${TAPE_NAME}"-

# Write list of files for ffmpeg to concatenate
rm -f list.txt && find . -name "${TAPE_NAME}*.avi" -exec echo "file '{}'" >> list.txt \;

# Concatenate all video files into one
# ffmpeg -f concat -safe 0 -i list.txt -c copy "${TAPE_NAME}_concatenated.avi"
# move file to directory for HandBrake to convert
# mv "${TAPE_NAME}_concatenated.avi" "${BASE_DIR}/to-convert"
