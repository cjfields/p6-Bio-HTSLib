use v6;
use Test;
use lib './lib';
use lib './src/htslib';
use Bio::HTSLib::BGZF;

ok my $lib = Bio::HTSLib::BGZF.new(), 'module loads';

# test reading

done();