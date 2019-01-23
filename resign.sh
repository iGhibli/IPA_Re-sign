 #!/bin/sh

#  resign.sh
#  Resign ipa.
#
#  Created by iGhibli on 2019/01/22.
#  Copyright © 2019年 iGhibli All rights reserved.

echo "Start..."
echo "The current execute content is: $0 $1"

current_path=$(pwd)

input_path=$1

ipa_file_extension=${input_path##*.}
ipa_file=$(basename ${input_path})
ipa_file_name=${ipa_file%.*}
ipa_dir=$(dirname ${input_path})

# echo $ipa_file_extension
# echo $ipa_file
# echo $ipa_file_name
# echo $ipa_dir
# echo $current_path

debug_dir="$ipa_dir/debug/"
dis_dir="$ipa_dir/dis/"

mkdir $debug_dir
mkdir $dis_dir


# Rename xxx.mobileprovision file to embedded.mobileprovision.
embedded_mobileprovision_path=${current_path}"/embedded.mobileprovision"

for f in `ls $current_path`
do
	if [[ ${f##*.} == "mobileprovision" ]];then cp -f "${current_path}/$f" "${debug_dir}embedded.mobileprovision"
		# src_path="${current_path}/$f"
		# dst_path="${debug_dir}embedded.mobileprovision"
		echo $f
	fi
done

# cp $embedded_mobileprovision_path ${debug_dir}"/embedded.mobileprovision"
cp $input_path ${debug_dir}${ipa_file_name}"_debug.ipa"
cp $input_path ${dis_dir}${ipa_file_name}"_dis.ipa"

# Execute sigh script with automated interaction.
cd $debug_dir

expect -c "
spawn sigh resign
expect {
\"*Identity:\" {set timeout 300; send \"1512EBB207FF14227EFE1C8D60C7E09BB4E740D8\r\";}
}
expect eof" 


# Delete temp mobileprovision file.
rm ${debug_dir}"/embedded.mobileprovision"

echo "Done."