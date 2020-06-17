#! /bin/bash
var=$1
path=$2
current=$PWD
finddir(){
while read line
do
	if [[ ! -d "directories" ]]; then
    	mkdir directories
    	echo "Created directories folder"
    fi
    dom=$line
    cd $path
    echo "Started finding directories of $line"
    search=$(python3 dirsearch.py -u $line -e php,asp,aspx,jsp,html,zip,jar --simple-report=$current/directories/$line.txt)
    echo "saved directories of $line in directories/$line.txt"
done < $var	
}

if [[ $var != *.* ]]; then
	echo "Provide the subdomains file"
	echo "Invalid syntax"
	echo "usage : $0 domains.txt path_to_dirsearch"
elif [[ $path == "" ]]; then
		echo "Provide the path to dirsearch tool"
		echo "Invalid syntax"
		echo "usage : $0 domains.txt path_to_dirsearch"
else

	finddir
fi
