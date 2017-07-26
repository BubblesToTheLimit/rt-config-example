# Mail-Config
Set($EmailImportServers, [qw(zzz)]);
Set($SetOutgoingMailFrom, 'support@zzz');
Set($OverrideOutgoingMailFrom, {
	'Default' => 'support@zzz',
	'General' => 'support@zzz',
});
# The following doesnt work even though it is recommended in the docs:
#Set($MailCommand , 'sendmailpipe');
Set($MailCommand, 'sendmail');
Set($CorrespondAddress, 'support@zzz');
Set($SendmailPath, "/usr/sbin/sendmail");
Set($NotifyActor, 1);

# Add to and cc to the ticket's CC field
Set($ParseNewMessageForTicketCcs , 1);
# ParseNewMessageForTicketCcs requires a RTAddressRegexp (https://www.bestpractical.com/docs/rt/4.2.0/RT_Config.html#RTAddressRegexp)
# see here for more tipps: http://requesttracker.wikia.com/wiki/RTAddressRegexp
Set($RTAddressRegexp , '^(best\.support@zzz|support\@zzz)$');


# Send Mails to a file instead of actually sending them to the users
#Set($MailCommand, 'testfile');
#Set(%MailSendingOff, 1);

# Sendmail Arguments
# without the -f part we dont receive any bounce mails (NDRs)
Set($SendmailArguments , "-fsupport\@zzz -oi");

Set($UseFriendlyFromLine, 0);
