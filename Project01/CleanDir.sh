<<<<<<< HEAD
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
=======
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
>>>>>>> refs/remotes/origin/master
    find . -name "*.tmp" -delete