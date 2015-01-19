#!/bin/bash
#Author: Arun Surath
#This first line declares the file as a bash script

#These next two lines create a directory called airfoils and move into it
mkdir airfoils
cd airfoils

#Then we download the webpage which has all the links to the downloads we are interested in
wget http://m-selig.ae.illinois.edu/ads/coord_database.html

#The file is saved as .html but it is asctually just a UTF8 encoded text file
#this next line does a regular expression search of STDIN, removes any matches and returns the result to STDOUT
#the left and right angle brackets hook STDIN to coord_database.html (which we downloaded above) and save the
#result into uiucuridatstrip.txt. The regular expression is created by noting the structure of the URI's we desire
#begins with the string "coord/"
sed -ne 's/.*\(coord\/[^"]*\).*/\1/p' < coord_database.html > uiucuridatstrip.txt

#The resulting text file has one uri per line in it, there we loop
#over each line in the file and set line equal to that lines value as a string
for line in $(cat uiucuridatstrip.txt) 
do
	#With this line we declare a string URL and build the appropriate URL from line
	url="http://m-selig.ae.illinois.edu/ads/coord_seligFmt/${line:6}"
	
	#with this line we store the file name to be saved at the url $url into the variable file
	file=$(basename $url)
	
	#with this line we retreive whatever file is at the url have built
	wget $url
	
	#here we save the 3rd line in the file we just downloaded into the variable line test
	linetest=$(sed '3q;d' $file)

	#if line test is null (the line is empty) then remove the second and third lines of the file (invalid format for xflr5/xfoil)
	if [ -n "$linetest" ];
	then
		sed -i.bak -e '2,3d' $file
	fi

	#move to next line/uri
done
