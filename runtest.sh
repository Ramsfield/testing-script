#!/bin/bash
#This script was created by Ramsfield
#For the sole purpose of testing and directing STDIN Programs
#Any concerns with this script can be directed to:
#Discord: Ramsfield#7696

#####################################
#	INSTRUCTIONS		    #
#####################################
#Place the .sh file in the directory with the program you wish to test it against
#The program MUST be named run and the test files must be in tests/t01.in, tests/t02.in tests/t03.in etc.
#Make sure this script has executable permissions -- chmod +x runtest.sh

#This script will create and clobber .myout and .cerr files of the same name as the test file name
#I.E. tests/t01.in will create a tests/t01.myout and tests/t01.myerr or overwrite any of the files that previously existed
#it will then run diff on the expected output and your output
#if diff returns nothing, it will give you a green Success statement
#if diff fails, you will get a red Failed statement

#all differences still need to be manually viewed in your .myout utilizing whatever methods you see fit
#the intention of this script is not to be an end all testing method for your program. Please run your own tests.

EXE=run

while getopts ":f" opt; do
	case ${opt} in
		f) EXE=$2
			;;
		\? ) echo "Options: cmd [-f] file name (optional) -- Set a executable, defaults to run"
			exit
			;;
	esac
done

echo -e "\n\033[34m\033[1mRunning tests on \033[103m$EXE\e[0m"

regmax=".*([0-9]{2}).*"
for i in $(ls tests/*.in)
do
	if [[ $i =~ $regmax ]] 
	then
		x="${BASH_REMATCH[1]}"
	echo -ne "\n\033[34mtest: $i: \e[0m"
	./$EXE <$i >tests/t$x.myout 2>tests/t0$x.myerr

		if [[ $(diff  tests/t$x.myout tests/t$x.out) ]]
		then
			echo -e " \033[31m Failed \e[0m"
		else
			echo -e " \033[32m Success \e[0m"
		fi
	fi

done
