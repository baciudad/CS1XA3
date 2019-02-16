#/bin/bash

echo "TODO.sh Executing"

mkdir Logs

cd ..

if [ -f Project01/Logs/todo.log ] ; then
    rm Project01/Logs/todo.log
fi

touch Project01/Logs/todo.log

grep -Hrn ".*#TODO.*" > Project01/Logs/TODO.log

echo "DONE, Please see TODO.log for Results"

