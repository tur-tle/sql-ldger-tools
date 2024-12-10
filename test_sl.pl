#!/usr/bin/env perl
use warnings;
use strict;
use diagnostics;
use FindBin qw($Bin);
use lib "$Bin";
use Data::Dumper;
use DBI;
use SL::User;
use SL::Form;
use SL::User;

# run from sql-ledger root directory.

### configure these : ###
my $userpath = './users';

# check users/members file for login in brackets []
#my $login      = 'admin@demo';
my $login = '';
###

my $memberfile = $userpath . '/members';
print "sql-ledger sanity test \n";
print qq| loaded libs \n|;
my $myconfig;
my $locale;
my $form;
my $script = 'login.pl';

$myconfig = User->new( $memberfile, $login );
print "\n user:";
print Dumper $myconfig;
print "\n locale:";
$locale = Locale->new( "$myconfig->{countrycode}", "$script" );
print Dumper $locale;

foreach my $sub (qw(continue email_tan login login_screen logout selectdataset tan_login )) {
    my $out = "$sub: ";
    $out .= $locale->findsub($sub);
    print "\t$out\n";
}
print "debug form:\n";
$ENV{QUERY_STRING} = qq|login=$login&terminal=console|;
$form = Form->new($userpath);
print Dumper $form;

