
#!/bin/bash

# There are 4 types of command available : 

# 1) Binary                   ( /bin  , /sbin )
# 2) Aliases                  ( Alises are shortcuts,  alias net="netstat -tulpn" )
# 3) Shell Built-in Commands  
# 4) Functions                # Functions are nothing but a set of command that can be written in a sequence and can be called n number of times as per your choice.


# How to declare a function ?

# f() {
#     echo hai
# }

# How do you call a function 

f   # calling a function

# sample() {
#     echo Hai from sample function
#     echo Sample function is completed
# }


# sample 

# echo sample call is completed 

# sample 


b56() {
    echo "This is our batch56 function"
    echo "We are learning functions"
    echo "Todays date is:"
    date 
    echo "function b56 is completed"
}


b56 


stat() {

    echo "Number of sessions opened $(who|wc -l)"
    echo "Todays date is $(date +%F)"
    echo "AVG Cpu Utilization In The Last 5 minues is : $(uptime|awk -F : '{print $NF}' | awk -F ',' '{print $2}')"

    b56  # calling a function from another function
}