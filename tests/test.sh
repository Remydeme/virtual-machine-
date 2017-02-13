#!/bin/sh


for arg in $(ls good) ; do
echo "################### $arg ########################"
    output=$(./thl "./good/"$arg"")
    echo "$?"
done 

for arg in $(ls syntax) ; do
echo "################### $arg ########################"
    output=$(./thl "./syntax/"$arg"")
    echo "$?" 
done 

