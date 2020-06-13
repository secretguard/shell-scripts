#! /bin/bash
read -p "Enter the domain :  " dom
echo $dom > target.txt
cat target.txt | httprobe >target_validity.txt
rm target.txt
cat target_validity.txt

if [ -s target_validity.txt ]
	then
		echo "Domain is valid"
			if [ ! -d $dom ]
				then
					echo "folder is not present.. Creating a folder named $dom"
					mkdir $dom
			fi
		echo "Collecting Subdomains using Assetfinder......."
		assetfinder -subs-only $dom > $dom/subs.txt
		echo "Collecting subdomains using Sublis3r"
		sublist3r -d $dom >> $dom/subs.txt
		sort -u $dom/subs.txt
		count=$(cat $dom/subs.txt | wc -l)
		echo "Found $count subdomains and saved in the folder $dom"
else
	echo "Domain is not valid, Exiting.."
fi
rm target_validity.txt