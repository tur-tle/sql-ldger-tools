#!/usr/bin/perl
use warnings;
use strict;

my $dirpath = $ARGV[0];
$dirpath ||= 'templates';
print "Upgrading $dirpath to utf8";


&process_dir($dirpath);

sub process_dir {
    my $dirpath = shift @_;
    opendir DIR, $dirpath || die "can't open dir $dirpath for reading:$!";
    my @entries = readdir DIR;
    closedir DIR;
    foreach my $entry (@entries) {
        my $path = "$dirpath/$entry";
        if ( -d $path && $entry !~ /^\./ ) {
            &process_dir($path);
        }
        elsif ( ($entry !~ /^\./) and ($entry =~ /\.tex$/) ) {
            print "Processing latex file $path\n";
            my $rv = `perl -i'.bak' -pe 's|latin1|utf8|g' $path`;
            #my $rv = `perl -i'.bak' -pe 's|utf8|latin1|g' $path`;
            print "$rv\n" if $rv;
        }
    }
}

sub remove_backups {
#todo
}

