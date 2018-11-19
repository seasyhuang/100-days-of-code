#!/bin/bash

# youtube-dl help
if [[ $1 == "help" || $1 == "h" ]]; then
	youtube-dl --help
	echo "----------------------------------------------------------------------------"
	echo "Arg 1 = URL"
	echo "Arg 2 = output file name"
	exit
fi

# make sure that first argument is a URL
if [[ $1 != "https://"* ]]; then
    echo "Invalid URL"
	exit
fi

if [ $# -eq 2 ]; then
	echo Output name: $2
fi

# bring up list of available formats
youtube-dl -F $1

read -p "ENTER FORMAT CODE (audio video):" audio video

echo Downloading audio...
youtube-dl -f $audio $1 --output "temp_audio.%(ext)s"

echo Downloading video...
youtube-dl -f $video $1 --output "temp_video.%(ext)s"

echo Mirroring video...
ffmpeg -i temp_video.mp4 -vf hflip temp_mirror.mp4

echo Deleting temporary video...
rm temp_video.*

echo Combining audio and video...
ffmpeg -i temp_mirror.* -i temp_audio.* -codec copy -shortest mirror_final.mp4
if [ $# -eq 2 ]; then
	f=$2
	ext=".mp4"
	mv "mirror_final.mp4" "${f}${ext}"
fi

echo Removing leftover files...
rm temp_audio.*
rm temp_mirror.*

echo Complete.

# test:
# https://www.youtube.com/watch?v=oawUi9s3ENE
#
# potentially useful:
# extension="${file##*.}"                     # get the extension
# filename="${file%.*}"                       # get the filename
# mv "$file" "${filename}001.${extension}"    # rename file by moving it
