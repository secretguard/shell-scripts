#! /bin/bash
file=$1
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`
bold=`tput bold`
arrow=$(echo -e ${bold}"\u27F6")
sp=$(echo -e ${bold}"\u0020")
smile=$(echo -e ${bold}"\U1F60E")

cname_check(){
sub_count=$(cat subdomains.txt | wc -l)
echo "TOTAL SUBDOMAINS : ${sub_count}"
echo "Collecting CNAME of the subdomains ${smile}"
	while read line
do
    name=$line
    cname=$(dig $line CNAME +short)

    if [[ -z "$cname" ]]; then
    	echo -e CNAME of ${bold}${red}$line${reset} NOT FOUND
    else
    	echo -e ${bold}${green}$line${reset} ${arrow} ${sp} ${bold}${blue}$cname${reset}
    	echo ${cname} >> cnames.txt
    fi
    
    
done < $file
}
if [[ -z "$file" ]]; then
	echo "INVALID SYNTAX. usage: ./gathercname file.txt"
else
	cname_check
	read -p "Do you want to save the list CNAMEs [ENTER = NO] ? " save
case $save in
	[yY][eE][sS]|[yY])
	mv cnames.txt cnamerecords.txt
	echo saved
	;;
	[nN][oO]|[nN] )
	rm cnames.txt
	echo "NOT SAVED"
	;;
	*)
	rm cnames.txt
	echo "NOT SAVED"
esac
fi