package AA::GAMP;

use strict;
use warnings;

use AA qw/:attributes :keycodes :mouse/;

sub new {
    my $cls = shift;
    my $self = {aa=>AA->new};
    bless $self => $cls;
    $self->init;
    $self;
}

sub init {
    my $self = shift;
    $self->aa->easyinit;
    $self->aa->autoinitkbd(0);
    $self->aa->autoinitmouse(0);
}

sub aa {
    my $self = shift;
    $self->{aa};
}

sub run {
    my $self = shift;
    $self->{_cont} = 1;
    while ($self->{_cont}) {
        $self->event;
        $self->aa->flush;
        select(undef,undef,undef,0.02);
        $self->funk;
    }
}

sub event {
    my $self = shift;
    my $event = $self->aa->getevent(0);
    if ($event == 0) {
        return 0;
    }
    if ($event == AA_MOUSE) {
        return $self->mouse_event($event);
    }
    else {
        return $self->kbd_event($event);
    }
}

sub mouse_event {
    my $self = shift;
    my $event = shift;
    my ($x, $y, $b) = $self->aa->getmouse();
    $x*=2;
    $y*=2;
    if ($b == AA_BUTTON1) {
        $self->dot($x,$y,int(rand(120)));
    }
    elsif ($b == AA_BUTTON3) {
        $self->dot($x,$y,0);
    }
    elsif ($b == AA_BUTTON2) {
        $self->clear;
    }
    else {
        # release
    }
}

sub clear {
    my $self = shift;
    map {my$x=$_;map {$self->draw($x,$_,0)} (0..$self->aa->imgheight)} (0..$self->aa->imgwidth);
    $self->refresh;
}

sub refresh {
    my $self = shift;
    $self->aa->fastrender(0,0,$self->aa->scrwidth,$self->aa->scrheight);
    $self->aa->flush;
}

sub draw {
    my $self = shift;
    my ($x, $y, $b) = (shift,shift,shift);
    $self->aa->putpixel($x,$y,$b);
}

sub funk {
    my $self = shift;
    foreach my $x (0..$self->aa->imgwidth-1) {
        foreach my $y (0..$self->aa->imgheight-1) {
            if (rand>0.998) {$self->aa->putpixel($x,$y,$x+$y<80?$x:(($x+$y)<100?($x+$y==89?150:0):$y*8))}
        }
    }
    $self->refresh;
}

sub dot {
    my $self = shift;
    my ($x,$y,$b) = @_;
    my $r = sub{int(rand(25))};
    for (my$X=$x-$r->();$X<=$x+$r->();$X++) {
        if ($X) {
            for (my$Y=$y-$r->();$Y<=$y+$r->();$Y++) {
                if ($Y) {
                    $self->draw($X,$Y,$b);
                }
            }
        }
    }
    $self->refresh;
}

sub kbd_event {
    my $self = shift;
    my $event = shift;
    print "kbd: ".chr($event)."\n";
    if ($event == ord('q')) {
        $self->{_cont} = 0;
    }
}

sub DESTROY {
    my $self = shift;
    $self->aa->uninitmouse;
    $self->aa->uninitkbd;
}

1;
__END__

=head1 NAME

AA::GAMP - The GNA ASCII Manipulation Program

=head1 SYNOPSIS

  use AA::GAMP;
  blah blah blah

=head1 ABSTRACT

  This should be the abstract for AA::GAMP.
  The abstract is used when making PPD (Perl Package Description) files.
  If you don't want an ABSTRACT you should also edit Makefile.PL to
  remove the ABSTRACT_FROM option.

=head1 DESCRIPTION

Stub documentation for AA::GAMP, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

root, E<lt>root@internE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by root

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
