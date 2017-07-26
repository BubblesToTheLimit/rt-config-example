#!/bin/bash
#Autor: Felix Brilej

# Filters the rt.log for useful information (errors)
# Can be called like this: ./filter_rt_log.sh .1
# This looks at /opt/rt4/var/log/rt.log.1
# Makes it so that this script doesnt have to be edited to look at a rotated file


logfile_base="/opt/rt4/var/log/rt.log"
logfile_extension=$1
logfile=$logfile_base$logfile_extension

# Check if file exists
if [[ ! -f $logfile ]] ; then
    echo "File $logfile is not there, aborting."
    exit
fi

beginning=$(grep -m 1 -P "\d{5}" $logfile | cut -d "]" -f2)
finish=$(tac $logfile | grep -m 1 -P "\d{5}" | cut -d "]" -f2)

echo -e "Displaying $logfile from\n$beginning to \n$finish"
cp $logfile /tmp/rt.log.copy;
sed -i "/\[error\]: No user found for CN=Grp_/d" /tmp/rt.log.copy;
sed -i "/\[error\]: No user found for CN=G_/d" /tmp/rt.log.copy;
sed -i "/couldn't create user_obj for /d" /tmp/rt.log.copy;
sed -i "/No Name or Emailaddress for user, skipping/,+5 d" /tmp/rt.log.copy;
sed -i "/LDAP search failed Bad filter/,+1 d" /tmp/rt.log.copy;
sed -i "/Use of uninitialized value in string eq at /,+1 d" /tmp/rt.log.copy;
sed -i "/Use of uninitialized value \$href in substitution (s\/\/\/) at \/usr\/local\/share\/perl\/5.18.2\/HTML\/FormatText\/WithLinks.pm/d" /tmp/rt.log.copy;
sed -i "/Use of uninitialized value \$_\[2\] in join or string at (eval/d" /tmp/rt.log.copy;
sed -i "/Use of uninitialized value \$ptag in string eq at \/usr\/local\/share\/perl\/5.18.2\/HTML\/Element.pm line/d" /tmp/rt.log.copy;
sed -i "/\[warning\]: Use of uninitialized value \$tag in string eq at \/usr\/local\/share\/perl\/5.18.2\/HTML\/Element.pm/d" /tmp/rt.log.copy;
sed -i "/\[warning\]: Use of uninitialized value in pattern match (m\/\/)/d" /tmp/rt.log.copy;
cat /tmp/rt.log.copy
