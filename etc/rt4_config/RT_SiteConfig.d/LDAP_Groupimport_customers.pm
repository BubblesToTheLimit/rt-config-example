# Temporary definition for ldap import: Customers
Set($LDAPHost,'xxx');
Set($LDAPBase, 'ou=users,dc=xxx');
Set($LDAPFilter, 'objectClass=*');
Set($LDAPMapping, {Name         => 'uid', # required
                    EmailAddress => 'uid',
                    #RealName     => 'sn',
                    RealName     => [qw/givenName sn/],
                    #Nickname     => 'givenName', doesnt work
                    Organization => 'homeDirectory'});


# Group syncronisation
Set($LDAPGroupBase, 'ou=customers,ou=groups,dc=xxx');
Set($LDAPGroupFilter, 'cn=c_*');
Set($LDAPGroupMapping, {
    Name               => 'cn',
    Description        => 'description',
    Member_Attr        => 'memberUid',
    Member_Attr_Value  => 'uid'
});
