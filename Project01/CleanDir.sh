#!/bin/bash

echo "Directory Name: $1"
testVar=$1
while [ ! -d "$testVar" ]; 
  do
    echo -n "Invalid directory name, please enter a different name: "
    read testVar
    done
	  
    cd ..

    cd $testVar
    find . -name "*.tmp" -delete