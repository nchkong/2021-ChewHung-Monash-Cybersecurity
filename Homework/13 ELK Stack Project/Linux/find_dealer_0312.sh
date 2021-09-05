#!/bin/bash
#Two arguements are used here. $1 is time (00:00:00) and $2 is AM/PM
#To run the script   ./find_dealer_0310.sh 05:00:00 AM

grep "$1 $2" 0312* | awk -F " " '{print  $1,$2,$5,$6}'
