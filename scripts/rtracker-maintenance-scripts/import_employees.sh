#!/bin/sh
#Author: Felix Brilej

# In RT only one group can be configured for the regular groupimport at a time
# In our case, this is the one of our customers
# Sometimes we have to import new colleagues from our employee AD too, so thats what we do here
#
# If this is not done, new, unimported employees can still login, but their group memberships
# are not yet imported, which means none of the privileges managed using groups work.

# Check whether the files are where they are expected, otherwise write abuot that in the RT log
if [ ! -e /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_employees.pm_disabled ]
then
	echo "CRITICAL: couldnt execute import_employee.sh script since the required files were not found" >> /opt/rt4/var/log/rt.log
	exit 1
fi
if [ ! -e /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_customers.pm ]
then
        echo "CRITICAL: couldnt execute import_employee.sh script since the required files were not found" >> /opt/rt4/var/log/rt.log
        exit 1
fi

# Enable the employee groupimport settings by changing its file-ending back to .pm
# Do the opposit to the customers groupimport settings
mv /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_employees.pm_disabled /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_employees.pm
mv /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_customers.pm /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_customers.pm_disabled

# Execute the import
/opt/rt4/sbin/rt-ldapimport --import > /opt/rt4/var/log/groupimport_employees 2>&1

# Copy the files back to where they were
mv /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_employees.pm /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_employees.pm_disabled
mv /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_customers.pm_disabled /opt/rt4/etc/RT_SiteConfig.d/LDAP_Groupimport_customers.pm

# Tell the log that the groupimport has been finished successfully
echo "HAPPY: employee groupimport finished successfully" >> /opt/rt4/var/log/rt.log
exit 0
