#!/bin/bash

# This command will remove the black space for the  $1*=filename which is only 4 digits of the date. $S2 is  specified time without a black between time and AM/PM
sed -r 's/[[:blank:]]+//1' $1_Dealer_schedule | grep $2 | awk -F " " '{print  $1,$4,$5}'
