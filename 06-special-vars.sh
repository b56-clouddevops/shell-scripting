#!/bin/bash 

# Special Variables are $0 to $9 , $* , $@, $#, $$ 
a=1000 

echo "Value of a is $a"
echo "Printing Script Name :  $0"

echo "First Argument is : $1 " 
echo "Second Argument is : $2 " 

#  bash scriptName.sh  arg1  arg2  arg3
# bash arg1  arg2  arg3 arg4  arg5  arg6 arg7  arg8  arg9  arg10 
#        1     2     3    4    5     6    7      8    9      10

#bash scriptName.sh  firstArg   secondArg   thirdArg
#                       $1         $2         $3

echo $0   # Prints Script Name 
echo $#   # Prints the overall arguments used in the script 
echo $?   # This prints the exit code of the last command
echo $*   # Prints all the arguments used.
echo $@   # Prints all the arguments used.