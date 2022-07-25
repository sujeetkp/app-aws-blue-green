#!/bin/bash

for ((i=0;i<500;i++))
do
curl https://${1}.simplifydev.co/  > /dev/null
done

#USAGE: ./test.sh blog