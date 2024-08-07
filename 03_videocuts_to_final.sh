#!/bin/bash

# Now glue all the video cuts together
cd videocuts

# Create the list of files in the ffmpeg format
touch file_list.txt
for f in $(ls | sort)
do
    extension=${f:${#f}-4:4}
    if [ ${extension} == ".mp4" ]; then
        str="file ${f}"
        echo ${str}
        echo ${str} >> file_list.txt
    fi
done

# Here the ffmpeg command to glue all the cuts together
cmd="ffmpeg -f concat -i file_list.txt -c copy final_video.mp4"
${cmd}
mv final_video.mp4 ../
echo "Final video is ready!"

echo
echo "*** Clean metadata/ and videocuts/ ? [lower case y = yes]"
read answer
if [ ! -z ${answer} ] && [ ${answer} == "y" ]; then
    echo "Removing metadata/"
    rm -r metadata
    echo "Removing videocuts/"
    rm -r videocuts
else
    echo "Folders metadata/ and videocuts/ have been preserved"
fi
