#!/bin/bash 

# Each and every color you see on terminal will have a color code and we need to use that code baesd on our need.

# Colors       Foreground          Background
# Red               31                  41
# Green             32                  42
# Yellow            33                  43
# Blue              34                  44
# Magenta           35                  45
# Cyan              36                  46


# Syntax to Print COLORS is : 

#  echo -e "\e[COLORCODEm I am printing Red color \e[0m"

echo -e "\e[31m I am printing Red color \e[0m"
echo -e "\e[32m I am printing GREEN color \e[0m"
echo -e "\e[33m I am printing YELLOW color \e[0m"
echo -e "\e[34m I am printing BLUE color \e[0m"
echo -e "\e[35m I am printing MAGENTA color \e[0m"

# Background + Foregroung
echo -e "\e[43;34m  I am printng backgrond + foreground \e[0m"
