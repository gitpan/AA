package AA;

use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 
        'attributes' => [ qw(
	        AA_NORMAL
            AA_DIM
            AA_BOLD
            AA_BOLDFONT
            AA_REVERSE
            AA_SPECIAL
            AA_NORMAL_MASK
            AA_DIM_MASK
            AA_BOLD_MASK
            AA_BOLDFONT_MASK
            AA_REVERSE_MASK
            AA_ALL
            AA_EIGHT
            AA_EXTENDED
        ) ],
        'keycodes' => [ qw(
            AA_RESIZE
            AA_MOUSE
            AA_UP
            AA_DOWN
            AA_LEFT
            AA_RIGHT
            AA_BACKSPACE
            AA_ESC
            AA_UNKNOWN
            AA_RELEASE
        ) ],
        'mouse' => [ qw(
            AA_BUTTON1
            AA_BUTTON2
            AA_BUTTON3
            AA_MOUSEMOVEMASK
            AA_MOUSEPRESSMASK
            AA_PRESSEDMOVEMASK
            AA_MOUSEALLMASK
            AA_HIDECURSOR
            AA_SENDRELEASE
            AA_KBDALLMASK
        ) ],
);


our @EXPORT_OK = ( 
        @{ $EXPORT_TAGS{'attributes'} },
        @{ $EXPORT_TAGS{'keycodes'} },
        @{ $EXPORT_TAGS{'mouse'} },
);

our @EXPORT = qw(
	
);

our $VERSION = '0.03';

require XSLoader;
XSLoader::load('AA', $VERSION);

# Preloaded methods go here.

use constant AA_NORMAL          => 0;
use constant AA_DIM             => 1;
use constant AA_BOLD            => 2;
use constant AA_BOLDFONT        => 3;
use constant AA_REVERSE         => 4;
use constant AA_SPECIAL         => 5;

use constant AA_RESIZE          => 258;
use constant AA_MOUSE           => 259;
use constant AA_UP              => 300;
use constant AA_DOWN            => 301;
use constant AA_LEFT            => 302;
use constant AA_RIGHT           => 303;
use constant AA_BACKSPACE       => 304;
use constant AA_ESC             => 305;
use constant AA_UNKNOWN         => 400;
use constant AA_RELEASE         => 65536;

use constant AA_NORMAL_MASK     => 1;
use constant AA_DIM_MASK        => 2;
use constant AA_BOLD_MASK       => 4;
use constant AA_BOLDFONT_MASK   => 8;
use constant AA_REVERSE_MASK    => 16;
use constant AA_ALL             => 128;
use constant AA_EIGHT           => 256;
use constant AA_EXTENDED        => AA_ALL|AA_EIGHT;

use constant AA_BUTTON1         => 1;
use constant AA_BUTTON2         => 2;
use constant AA_BUTTON3         => 4;
use constant AA_MOUSEMOVEMASK   => 1;
use constant AA_MOUSEPRESSMASK  => 2;
use constant AA_PRESSEDMOVEMASK => 4;
use constant AA_MOUSEALLMASK    => 7;
use constant AA_HIDECURSOR      => 8;
use constant AA_SENDRELEASE     => 1;
use constant AA_KBALLMASK       => 1;

sub getmouse {
    my $self = shift;
    $self->_getmouse;
    return ($self->getmousex,$self->getmousey,$self->getmouseb);
}

sub parseoptions {
    my $self = shift;
    my @args;
    if (ref($_[0])eq'ARRAY') {
        @args = @{$_[0]};
    }
    elsif (!@args) {
        @args = @ARGV;
    }
    unshift(@args,$0);
    return $self->_parseoptions([@args]);
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

AA - Perl extension for aalib

=head1 SYNOPSIS

 This module is work in progress.
 Some cool scripts can be found in the scripts/ directory.
 Try clicking on the animations:)

=head1 DESCRIPTION

 Perl bindings for aalib

=head2 EXPORT

None by default.
lots of constants on request tho, check the source

=head1 SEE ALSO

  http://aa-project.sourceforge.net
  perlguts(1)

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

root, E<lt>rlzwart@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Raoul Zwart

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
