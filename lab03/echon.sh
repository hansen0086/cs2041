#!/bin/sh


#check the number of arguments
if [ $# != 2 ];
then
	echo "Usage: ./echon.sh <number of lines> <string>"
	exit 1
fi

#check if the fist argument is a non-negative number
if ! [[ $1 =~ ^[0-9]+$ ]];
then
	echo "./echon.sh: argument 1 must be a non-negative integer"
	exit 1
fi

#echo the second argument message for $1 times
for ((i=0;i<$1 ; i++));
do
	echo $2
done
