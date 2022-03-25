#!/bin/bash
read -p "Location of list" listlocation

# checks if listlocation file exists and sees if it is a file
cat $listlocation > /dev/null && listcontent=$(cat $listlocation)
mkdir ~/setuid 2> /dev/null

# goes through every ip/host provided by list
for i in $listcontent
do
        # if file can be touched without error, ssh: and sends matches to specified to touched file
        touch ~/setuid/$i
        if [[ $? -eq 0 ]]; then
                ssh $i '(find / -perm -u+s 2> /dev/null)' &> ~/setuid/$i
        else
                echo "error! cant create file"
                exit 1;
        fi
done
