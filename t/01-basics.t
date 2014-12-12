use v6;
use Test;
use lib 'blib/lib';
use Bio::HTSLib;

plan 2;

ok my $lib = Bio::HTSLib.new(), 'module loads';
ok $lib.install-library(), 'library called';
