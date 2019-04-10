#!/bin/bash
# bc
echo "56.8 + 77.7" | bc
echo "obase=16; ibase=10; 56" | bc # convert decimal to hexadecimal
echo "scale=6; 60/7.02" | bc # perform division with 6 digits
echo 2/5 | bc -l
#m=34
#bc <<< "scale = 10; ($m - 20) / 34"

# printf and bc
#printf "%.3f\n" "$(bc -l <<< 1.2)

# bash and printf
printf %.10e $(( 24**10 ))

# awk
m=34; awk -v m=$m 'BEGIN { print 1 - ((m - 20) / 34) }'

# x3 thousand, x6 million, x9 billion, x12 trillion
