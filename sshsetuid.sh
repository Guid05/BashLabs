#!/bin/bash
read -p "Location of list" listlocation

listcontent=$(cat $listlocation)
mkdir ~/setuid 2> /dev/null

for i in $listcontent
do
        touch ~/setuid/$i
        if [[ $? -eq 0 ]]; then
                ssh $i '(find / -perm -u+s 2> /dev/null)' &> ~/setuid/$i
        else
                echo "error! cant create file"
                exit 1;
        fi
done
