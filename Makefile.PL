use ExtUtils::MakeMaker;

print 
    "\nNOTE: for 'make test' to work you must be connected to the Internet\n\n";

WriteMakefile(
    NAME		=> 'WWW::Mechanize::Sleepy',
    VERSION_FROM	=> 'Sleepy.pm', 
    PREREQ_PM		=> { WWW::Mechanize => 0.58 },
    ABSTRACT_FROM	=> 'Sleepy.pm', 
    AUTHOR		=> 'Ed Summers <ehs@pobox.com>',
);
