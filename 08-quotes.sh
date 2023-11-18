#!/bin/bash 

echo "$$"    # $$  is going to print the PID of the current proces 
echo '$$'    # Single Quotes Always Eliminates The Power Of The Special Variable 

echo $? 
echo "$?"
echo '$?'