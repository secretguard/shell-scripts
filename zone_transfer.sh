#! /bin/bash
read -p 'Domain Name : ' domain
var=$(dig $domain NS +short)
echo $var
sleep 3
dig axfr $domain @$var
