#!/bin/bash

re='^[0-9]+$'
if [[ $UID -eq 0 ]] ; then
	read -p 'Command? [Create/Remove/List]: ' varCommand
	varCommand=$Varcommand| tr '[:upper:]' '[:lower:]'
	if [[ ($varCommand == "create") || ($varCommand == "remove") ]]
		then read -p "Number of the user to be ${varCommand}d: " varNumber 
	elif [[ $varCommand == "list" ]] 
		then cat /etc/passwd | grep user[0-9]
	else 
		exit 1; 
	fi
	if ! [[ ($varNumber =~ $re) || ($varNumber -gt 20) ]] ; then
		if [[ $varCommand != "list" ]] ; then echo "Invalid command or amount"; exit 1; else exit 1; fi
	else
		if [[ $varCommand == "create" ]]
			then useradd user$varNumber;
			echo "Successfully added user$varNumber";
		else
			read -p "Are you sure? This action is permanent y/N: " varConfirm
			varConfirm=varConfirm| tr '[:upper:]' '[:lower:]'
			if [[ $varConfirm == "y" ]] ; then
				userdel -r user$varNumber;
				echo "Successfully removed user$varNumber";
			else
				echo "Abort."
				exit 1; fi

		fi
	fi
else
	echo "Permission denied, Are you root?"
	exit 1;
fi
