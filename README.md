run-and-install-all-perl-modules
================================

When you want to run a perl script and INSTALL ALL THE THINGS use this.

run-and-install-all-perl-modules.pl
 This is a simple script with one goal.
 That goal is to be able to run a perl script, and automatically install any of its dependencies.
 It does this in a simplistic way: by trying to run the script and then looking at what .pm files
  were nout found, then installing those with cpanm.  Then it tries again and repeats.

Call it like ./run_... 'some_script.pl --someoption somevalue'