use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'		=> 'AA',
    'VERSION_FROM'	=> 'AA.pm',
    ($] >= 5.005 ? 
       (AUTHOR     => 'Raoul Zwart <rlzwart@cpan.org>') : ()),
    'LIBS'		=> ['-laa -lstdc++'],
    'DEFINE'		=> '-Wno-deprecated -fpermissive',
    'INC'		=> '-I.',
    'CC'        => 'g++',
    'LD'        => '$(CC)',
    'XSOPT'     => '-C++',
    'TYPEMAPS'   => ['perlobject.map'],
);
