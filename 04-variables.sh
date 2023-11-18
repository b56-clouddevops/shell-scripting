#!/bin/bash 

# What is a variable ?
# A variable is something that holds data dynamically

# the advantage & disadvantage in shell is that there are no Data Types

a=10 
b=abc 
# In bash, everything will be considered as string by default.

# How can we print a variable ?  $var

echo $a 
echo printing the value of a $a 
echo printing the value of a ${a} 

echo printing the value of b ${b}
