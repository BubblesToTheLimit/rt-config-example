#!/bin/bash
#Autor: Felix Brilej

# Filters the fetchmail.log for useful information (errors)
# Can be called like this: ./filter_fetchmail_log.sh .1
# This looks at /var/log/fetchmail.log.1
# Makes it so that this script doesnt have to be edited to look at a rotated file


logfile_base="/var/log/fetchmail.log"
logfile_extension=$1
logfile=$logfile_base$logfile_extension

# Check if file exists
if [[ ! -f $logfile ]] ; then
    echo "File $logfile is not there, aborting."
    exit
fi

beginning=$(grep -m 1 -e "^[a-Z][a-Z][a-Z] " $logfile)
finish=$(tac $logfile |  grep -m 1 -e "^[a-Z][a-Z][a-Z] ")

echo -e "Displaying $logfile from\n$beginning to \n$finish"
cp $logfile /tmp/fetchmail.log.copy
sed -i '/Warning: the connection is insecure, continuing anyway./d' /tmp/fetchmail.log.copy
grep -iE '(fail|warning|error|critical)' /tmp/fetchmail.log.copy
