run-and-install-all-perl-modules
================================

When you want to run a perl script and INSTALL ALL THE THINGS use this.

NAME run-and-install-all-perl-modules.pl

DESCRIPTION
      This is a simple script with one goal.
      That goal is to be able to run a perl script, and automatically install any of its dependencies.
      It does this in a simplistic way: by trying to run the script and then looking at what .pm files
       were nout found, then installing those with cpanm.  Then it tries again and repeats.

      Beware that ... it'll do what it says and install any dependent modules using cpanm without prompting you.  
      Make your peace with this or don't use this script.

      Also, it'll of course fail to install any dependent modules that can't be installed with cpanm ... that part is up to you.

USAGE
     Call it like ./run-and-install-all-perl-modules.pl 'the_script_to_run.pl --someoption somevalue'