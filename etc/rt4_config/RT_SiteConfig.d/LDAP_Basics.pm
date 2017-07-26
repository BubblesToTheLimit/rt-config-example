#This line is required by Upgrade Notes 4.4
Set($ExternalAuth, 1);

Set($ExternalSettings, {
# ------------------------------------------------
# Customer LDAP Import-Settings for Authentication
# ------------------------------------------------
'LDAP_Customers'       =>  {
    'type'             =>  'ldap',
    'server'           =>  'xxx',
    #By not passing 'user' and 'pass' we are using an anonymous bind
    'base'             =>  'ou=users,dc=xxx',
    'filter'           =>   '(objectClass=*)',
    # The filter that will only match disabled users
    # it says somewhere that this filter is required
    'd_filter'         =>  '(&(objectCategory=person)(uid=user))',
    # dont try tls encryption
    'tls'              =>   0,
    #Users are allowed to log in via the following properties
    'attr_match_list'  => [
        #'Name', doesnt work but is recommended
        'EmailAddress',
    ],
    #Import the following properties of the user from LDAP upon login
    'attr_map' => {
	'Name'                  => 'uid',
	'RealName'              => 'cn',
        'EmailAddress'          => 'cn',
        'Organization'          => 'o',
    },
},
# ---------------------------------------------------------
# Employee LDAP Import-Settings for Authentication
# ---------------------------------------------------------
'LDAP_Employees'       =>  {
    'type'             =>  'ldap',
    'server'           =>  'yyy',
    'user'             =>  'user',
    'pass'             =>  'password',
    'base'             =>  'OU=Users,OU=yyy',
    'filter'           =>  '(objectClass=organizationalPerson)',
    'd_filter'         =>  '(&(objectCategory=person)(uid=user))',
    #Users are allowed to log in via the following properties
    'attr_match_list'  => [
	'Email'
    ],
    #Import the following properties of the user from LDAP upon login
    'attr_map' => {
	'Name'          => 'sAMAccountName',
	'Email'		=> 'mail',
	'Organization'  => 'company',
    }
}
} );

Set($UserAutocreateDefaultsOnLogin, { Privileged => 0 } );
Set($LDAPUpdateUsers, 1);
Set($LDAPSkipAutogeneratedGroup, 1);

# Users should still be autocreated by RT as internal users if they
# fail to exist in an external service; this is so requestors (who
# are not in LDAP) can still be created when they email in.
Set($AutoCreateNonExternalUsers, 1);

# Use the below LDAP source for both authentication, as well as user
# information
# Commenting / Uncommenting these influences the ldapimport i think
Set( $ExternalAuthPriority, ["LDAP_Customers", "LDAP_Employees"] );
Set( $ExternalInfoPriority, ["LDAP_Customers", "LDAP_Employees"] );