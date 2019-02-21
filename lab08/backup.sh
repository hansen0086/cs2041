#!/bin/sh

dot=.
i=0

#echo "$1$dot$i"

while true
do
    if [ -f $dot$1$dot$i ]; then
    ((i = i+1)) 
    else
    echo "Backup of '$1' saved as '$dot$1$dot$i'"
    cp $1 $dot$1$dot$i
    break
    fi
done
    
