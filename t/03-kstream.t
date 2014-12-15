use v6;
use Test;
use lib 'lib';
use lib 'src/htslib';

use Bio::HTSLib::KStream;

ok my $str = Bio::HTSLib::KStream.new(), 'module loads';

done();