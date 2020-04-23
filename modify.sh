#!/bin/bash 
 
#Functions : 
  
L_Case() 
{ 
        name_=$1 
        lname_=${name_,,} 
        if [ $lname_ == $name_ ] 
        then 
		if [ ! "$2" = -r ]
		then
                	echo "The name's file is already in lower case " 
		fi
        else 
                mv $name_ $lname_ 
        fi 
} 
 
U_Case() 
{	
        name_=$1 
        uname_=${name_^^} 
        if [ $name_ == $uname_ ] 
        then 
		if [ ! "$2" = -r ]
		then
                
			echo "The name's file is already in upper case " 
        	fi
	else 
                mv $name_ $uname_ 
        fi 
} 

Recursive()
{
	oriPath="$PWD"
	cd $1

	ls -R1 > ls.txt

	find < ls.txt > abspath.txt

	file -f abspath.txt | grep directory > ../dirabspath1.txt

	sed 's/:.*$//' < ../dirabspath1.txt > ../dirabspath2.txt

	curPath="$PWD"

	sed 's|.|'"$curPath"'|' < ../dirabspath2.txt > ../dirabspath1.txt

	cat ../dirabspath1.txt > ../dirabspath2.txt

	rm ls.txt
	rm abspath.txt

	while [ -s ../dirabspath1.txt ]
	do
		cd $(sed '$!d' < ../dirabspath1.txt)
		for element in *
		do
			if [ $2 = -u ]
			then
				U_Case $element -r
			else
				L_Case $element -r
			fi
		done
		
		cd $(echo $curPath)
		sed '$d' < ../dirabspath2.txt > ../dirabspath1.txt
		cat ../dirabspath1.txt > ../dirabspath2.txt
	done

	cd $(echo $oriPath)

	if [ $2 = -u ]
	then
		U_Case $1
	else
		L_Case $1
	fi

	rm dirabspath1.txt dirabspath2.txt
}

Sed_Command()
{
	sedPath=$(echo "$path" | sed $sedArg)
	mv $path $sedPath
}


#Get the last argument
if [ $# == 3 ]
then
	path=$3
else
	path=$2
fi


#test if the path exist
if [ ! -d $path ] && [ ! -f $path ]
then
	echo "The path : $path does not exist"
	exit
fi


#if the path is a file, -r can't be use
if [ -f $path ]
then
	for argument in $*
	do
		if [ -r == $argument ] || [ -ru == $argument ] || [ -ur == $argument ] || [ -rl == $argument ] || [ -lr == $argument ]
		then
			echo "$path is a file, you can't use -r"
			exit
		fi
	done
fi


#case with r
for argument in $*
do
	case $argument in
		-r)
			for argument2 in $*
			do
				case $argument2 in
					-l) #Case with r and l
						Recursive $path -l
						exit
						;;
					-u ) #Case with r and u
						echo "-ru"
						Recursive $path -u
						exit
						;;
				esac
			done
			;;
		-ru | -ur) #Case with r and u
			Recursive $path -u
			exit
			;;
		-rl | -lr) #Case with r and l
			Recursive $path -l
			exit
			;;
	esac
done


#Case -l/-u/-h

case $1 in
	-l)
		L_Case $path
		exit
		;;
	-u)
		U_Case $path
		exit
		;;
	-h | --h | -help | --help)
		echo -e "Usage: modify.sh [option]... [file]...\n"
		echo -e "  -u"
		echo -e "\t\t Rename the file in upper case"
		echo -e "  -l"
		echo -e "\t\t Rename the file in lower case"
		echo -e "  -r"
		echo -e "\t\t Rename directory and their content recusively"
		exit
		;;
	*) if [ $path != $2 ]
	then	
		SedCommand $path
	else
		echo -e "Wrong use of Modify"
		echo -e "Try Modify --help"
	fi
	exit
	;;
esac
