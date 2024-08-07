###########################################################################
#### STEP 2: Read the aaa.csv file and generate video cuts
###########################################################################

#!/bin/bash
metadata_folder="metadata"
mkdir videocuts
cd ${metadata_folder}

# Read the csv file, line by line
while read line
do
    info=$(echo ${line} | sed "s/,/ /g")
    echo "Reading information ${info}"
    read filename start end <<< ${info}
    echo "Cutting ${filename} from ${start} to ${end}"
    
    # Construct the name for the cut
    part1=$(tr -d [:] <<< ${start})
    part2=$(tr -d [:] <<< ${end})
    
    cut_name=${part1}-${part2}-${filename}
    echo "Output in ${cut_name}"

    cmd1="ffmpeg -i ${filename} -ss ${start} -to ${end}"
    cmd2=" -c:v copy -c:a copy ${cut_name}"
    cmd=${cmd1}${cmd2}
    echo "Command will be: ${cmd}"
	#cmd="touch ${cut_name}"
	${cmd}
    mv ${cut_name} ../videocuts/
    echo "   Cut ${cut_name} generated"

done < aaa.csv
