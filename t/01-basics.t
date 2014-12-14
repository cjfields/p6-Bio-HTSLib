use v6;
use Test;
use lib './lib';
use lib './src/htslib';
use Bio::HTSLib;

use Bio::HTSLib::Library;

plan 3;

ok my $lib = Bio::HTSLib.new(), 'module loads';
lives_ok { $lib.install-library() }, 'installed libhts library found';
ok $lib.install-library() ~~ /libhts\./, "Lib found:" ~ $lib.install-library()
