#!/bin/bash

#The script is meant to be run in the airfoils parent director so we begin by moving into the airfoils directory
cd ./airfoils

#Then we loop over each file in the working directory whose name ends with .dat
for file in ./*.dat
do
	#we write commands to a text file called xfoil.com, this first line overwrite the file and the subsequent lines append to it
	echo "pane" > xfoil.com
	echo "oper" >> xfoil.com
	echo "visc 7.5e5" >> xfoil.com
	echo "pacc" >> xfoil.com
	#this is the only real dynamic line which we need
	echo $file'.analysis' >> xfoil.com
	echo "" >> xfoil.com
	echo "aseq 0 14 1.0" >> xfoil.com
	echo "pacc" >> xfoil.com	
	echo "" >> xfoil.com
	echo "quit" >> xfoil.com

	#we then run xfoil with its STDIN hooked up to the text file where we just wrote the commands to
	xfoil $file < xfoil.com

	#finally we delete the dat file as we have created the polar
	rm $file
done

