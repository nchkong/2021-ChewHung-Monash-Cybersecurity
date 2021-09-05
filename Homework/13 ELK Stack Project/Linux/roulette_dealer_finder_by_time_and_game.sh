#!/bin/bash
# Bonus question -example of arguements $1=02:00:00AM $2=the four digits of the  date $3 enter single number  1= Blackjack 2=Roulette 3=Texas_Hold_EM

# If $3 equals to 1 or Blackjack then print out the time and  name of dealer
if [[ $3 -eq 1 ]] ; then
   sed -r 's/[[:blank:]]+//1' $1_Dealer_schedule | grep $2 | awk -F " " '{print  $1,$2,$3}'

# If $3 equals to 2 or Roulette then print out the time and name of the dealer 
elif [[ $3 -eq 2 ]] ; then
   sed -r 's/[[:blank:]]+//1' $1_Dealer_schedule | grep $2 | awk -F " " '{print  $1,$4,$5}'

# If $3 equals to 3 or Texas_Hold_EM then print the time and name of the dealer 
elif [[ $3 -eq 3 ]] ; then
   sed -r 's/[[:blank:]]+//1' $1_Dealer_schedule | grep $2 | awk -F " " '{print  $1,$6,$7}'
fi
