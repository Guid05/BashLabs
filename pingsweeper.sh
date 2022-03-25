#!/bin/bash

if [[ $# -eq 0 ]]
	 then read -p "What is the base address?: " baseAddr
else
	if [[ $# -gt 1 ]]
		then >&2 echo "Incorrect syntax, only 1 arg needed"; 
	else
		baseAddr=$1; fi

fi
pingsweeper () {
	if [[ "${1: -2}" != ".0" ]] ; then 
		>&2 echo "Ip addres is not a base address (is the last octet set to 0?)"
	else 
		local count=1
		local baseIp=${1:: -2}
		while [[ count -lt 254 ]]
		do
			echo "$baseIp.$count"
			let "count+=1"
		done
	fi
}
pingsweeper $baseAddr
