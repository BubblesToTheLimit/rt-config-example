# Any configuration directives you include  here will override
# RT's default configuration file, RT_Config.pm
#
# To include a directive here, just copy the equivalent statement
# from RT_Config.pm and change the value. We've included a single
# sample value below.
#
# This file is actually a perl module, so you can include valid
# perl code, as well.
#
# The converse is also true, if this file isn't valid perl, you're
# going to run into trouble. To check your SiteConfig file, use
# this command:
#
#   perl -c /path/to/your/etc/RT_SiteConfig.pm
#
# You must restart your webserver after making changes to this file.

# Logging
# The different debug levels are (in order):
# debug, info, notice, warning, error, critical, alert, emergency
Set($LogToFile , 'error');
Set($LogDir, '/opt/rt4/var/log');
Set($LogToFileNamed , "rt.log");

#Host settings
Set($rtname, 'Customer-Care');
Set($Organization, 'website.com');
Set($WebPath, "" );
Set($WebBaseURL , "https://website.com");
Set($WebDomain, 'website.com');
Set($Timezone, 'Europe/Berlin');

# Sets link behind the customizable logo in the top right corner
Set($LogoLinkURL, "http://www.otherwebsite.com");
Set($LogoURL, "logo.png");

# Disable plugins that produce error-messages
# Both of these plugins are available with the upgrade to 4.4
Set($DisableGD, 0);
Set($DisableGraphViz,  0);

# Change chartcolor from green to gray
Set(@ChartColors, qw(
    BDBDBD ff6666 ffcc66 663399
    3333cc 339933 993333 996633
    33cc33 cc3333 cc9933 6633cc
));

# Mysql-Backend Connection
Set($DatabaseHost,   "1.1.1.1);
Set($DatabaseRTHost, "1.1.1.1");
Set($DatabasePort, "3306");
Set($DatabaseUser, "rt_user");
Set($DatabasePassword, q{password});
Set($DatabaseName, q{rt4});
Set(%DatabaseExtraDSN, ());
Set($DatabaseAdmin, "rt_user");
#Set($DatabaseAdmin, "root");

# Fulltextsearch settings
Set( %FullTextSearch,
    Enable     => 1,
    Indexed    => 1,
    Table      => 'AttachmentsIndex',
);

# Allow inline messages of any size
Set($MaxInlineBody, 0);

# Hide empty ticket-fields
Set($HideUnsetFieldsOnDisplay, 1);

# Enable Infinite scroll by default
Set($ShowHistory, 'scroll');

# Remember the default Queue for quick ticket creation
Set($RememberDefaultQueue, 1);

# Important settings for improving performance with alot of users
Set($AutocompleteOwners, 1);
Set($AutocompleteOwnersForSearch, 1);

# Allow 15MB big attachments (irrelevant setting on its own)
Set($MaxAttachmentSize, 15*1024*1024);  # 15M

