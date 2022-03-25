#!/bin/bash

# checks if correct amount of parameters have been given
if [[ $# -eq 0 ]]
	 then read -p "What is the base address?: " baseAddr
else
	if [[ $# -gt 1 ]]
		then >&2 echo "Incorrect syntax, only 1 arg needed"; 
		exit 1;
	else
		baseAddr=$1; fi

fi
#function: checks if last 2 characters equal to .0 if so, ping every every going from 1 to 254
pingsweeper () {
	if [[ "${1: -2}" != ".0" ]] ; then 
		>&2 echo "Ip addres is not a base address (is the last octet set to 0?)"
		exit 1;
	else 
		# local variables, baseIp is equal to the last 2 characters of the 1st parameter
		local count=1
		local baseIp=${1:: -2}
		while [[ count -lt 255 ]]
		do
			echo "$baseIp.$count" && echo "$baseIp.$count is up"
			let "count+=1"
		done
	fi
}
pingsweeper $baseAddr
