#/bin/bash

echo "TODO.sh Executing"

cd ..

if [ -f Project01/Logs/todo.log ] ; then
    rm Project01/Logs/todo.log
fi

touch Project01/Logs/todo.log

grep -Hrn ".*#TODO.*" > Project01/Logs/todo.log

echo "DONE, Please see TODO.log for Results"