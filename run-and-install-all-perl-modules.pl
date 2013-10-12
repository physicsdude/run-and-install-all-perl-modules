#!/usr/bin/env perl
use warnings;
use strict;

=head1 NAME run-and-install-all-perl-modules.pl

=head1 DESCRIPTION

  This is a simple script with one goal.
  That goal is to be able to run a perl script, and automatically install any of its dependencies.
  It does this in a simplistic way: by trying to run the script and then looking at what .pm files
   were nout found, then installing those with cpanm.  Then it tries again and repeats.

  Beware that ... it'll do what it says and install any dependent modules using cpanm without prompting you.  
  Make your peace with this or don't use this script.

  Also, it'll of course fail to install any dependent modules that can't be installed with cpanm ... that part is up to you.

=head1 USAGE

 Call it like ./run-and-install-all-perl-modules.pl 'the_script_to_run.pl --someoption somevalue'

=cut

my $command = shift;
my $cpanm = shift || `which cpanm`; chomp $cpanm;
my $perl = shift || `which perl`; chomp $perl;
die 'need a command' if not $command;

while(1) {
	my $res = test_cmd("$perl $command");
	if ($res) {
		# Regex needs to match strings like:
		#  Can\'t locate Want.pm in foo (you may need to install the Want module) (@INC contains: 
		if ( $res =~ /Can't locate ([^.]+?)\.pm in \@INC/s 
			or $res =~ /Base class package "([^"]+)" is empty/s ) {
			my $mod = $1;
			$mod =~ s/\//::/g;
			print "Dependency found: $mod\n";
			my $cpanmcmd = "$cpanm $mod";
			print "Running $cpanmcmd\n";
			my $out = `$cpanmcmd 2>&1`;
			print "\n$out\n";
			if ($? != 0) {
				print "Error trying to install dependency $mod: $out\n";
				exit 1;
			}
			else {
				print "Installed dependency $mod, trying again.\n";
				next;
			}
		}
		else {
			print "Command failed for some other reason.: $res";
			exit(1);
		}
	}
	last;
}

sub test_cmd {
        my $cmd     = shift;
        print "Running command ($cmd)\n";
        my $out = `$cmd 2>&1`;
        return $out;
}

