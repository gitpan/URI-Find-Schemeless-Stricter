use 5.00503;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'URI::Find::Schemeless::Stricter',
    'VERSION_FROM'	=> 'Stricter.pm', # finds $VERSION
    'PREREQ_PM'		=> {URI::Find => 0}, 
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Stricter.pm', # retrieve abstract from module
       AUTHOR     => 'Simon Cozens <simon@kasei.com>') : ()),
);
