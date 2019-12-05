#!/usr/bin/env perl

$_=<>;
m/^begin ([0-7]+) (.+)$/ or die("Unable to find header");
my ($mode,$filename) = (oct($1), $2);

open(my $fh, '>', $filename) or die("Unable to open: '$filename'");
binmode $fh;
while($_=<>) {
    last if m/^end$/;
    my $out = unpack 'u*', $_;
    print $fh $out;
}
close($fh);
chmod $mode, $filename;
