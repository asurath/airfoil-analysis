This is meant to be a guide for how to use the three scripts in this folder as well as explain how I came up with them

Part 1: How to come up with it 

The task is too big to be looked at as 
a single program/problem so we must look at is as several smaller problems in sequence. Then we solve 
the problems one at a time knowing we have the ability to solve the next but not knowing 
anything of the particulars. 

so for this task, once I break it down, my individual problems become these:

	-download the airfoils
	-make them into valid file formats if needed
	
-run an analysis on all of them
	-parse the analysis into matlab
	-sort the data in a useful manner

now we no longer are lost in this gigantic problem, from a computer science perspective each 
one of these problems is reasonable

we note the first two tasks seem to fit well together and as I know how to do them manually at a linux prompt
I can write a bash script which calls the same 
commands I would call

then we have to use xfoil so we look at the tutorial and example command inputs, and do the same as before with
bash again

finally we use matlab for the last two problems, 
for which matlab has several built in functions to aid us

Part 2: How to use it

	requirements:
		linux
		bash
		wget
		xfoil
		sed

	
these things should be already installed or easily installed from standard unix distro's using apt-get or yum

	Steps:
		
create an empty directory and move the scripts into it
		

run stripuiuc.sh first with the command "bash stripuiuc.sh"
		
you should now be in a directory called airfoils with all the airfoils in it
		
navigate to the parent directory with the scripts in it again
		
run datanalysis.sh second with the command "bash datanalysis.sh"
		
unfortunately a couple of the airfoils cause xfoil to crash so if it does you must remove the airfoil
		
which caused it and run datanalysis.sh again
		
finally in order for the matlab script to work the matlab working directory must be the airfoil directoy
		
if matlab complains about the script not being in the working directory select "run from directory"
		
the results of the analysis will be saved to file whos name is hard coded into the matlab script
	


