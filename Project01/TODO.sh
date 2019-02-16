#/bin/bash

echo "TODO.sh Executing"

cd ..

if [ -f Project01/Logs/TODO.log ] ; then
    rm Project01/Logs/TODO.log
fi

touch Project01/Logs/TODO.log

grep -Hrn ".*#TODO.*" > Project01/Logs/TODO.log

echo "DONE, Please see TODO.log for Results"