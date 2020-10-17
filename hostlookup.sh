#!/bin/bash

# file hostlookup.sh
# brief  looks up the host ip address
# author gavin.lechner
# date 10/16/2020


usage()
{
   echo "$0 usage: [-f input filed] "
   exit 1
}

while getopts ":f:" options;
do
   case "${options}" in
      f)
         if [ -f ${OPTARG} ]; then
            f=${OPTARG}
         else
            usage
         fi
         ;;
      *)
      usage
      ;;
   esac
done

while read line
do
   out=$(host -W1 -t A $line)
   if [ $? -eq 0 ];then
      ip=$(echo $out | cut -d " " -f 4)
      echo ${line},$ip
   else
      echo "${line}, not found"
   fi
done < ${f}

exit 0
