#!/usr/bin/perl -w
use strict;
use lib './blib';
use AA qw/:attributes/;
my $a = AA->new();
unless ($a->easyinit) {
    die "failed to init aalib\n";
}
$a->hidecursor;
for (0..$ARGV[0]||10000) {
foreach my $x (0..$a->imgwidth-1) {
    foreach my $y (0..$a->imgheight-1) {
        if (rand>0.998) {$a->putpixel($x,$y,$x+$y<80?$x:(($x+$y)<100?($x+$y==89?150:0):$y*8))}
    }
}
$a->fastrender(0,0,$a->scrwidth,$a->scrheight);
$a->puts(0, 0, AA_SPECIAL, "sletjez");
$a->flush;
}
$a->showcursor;
