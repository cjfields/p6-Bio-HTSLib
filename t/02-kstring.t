use v6;
use Test;
use lib 'lib';
use lib 'src/htslib';

use Bio::HTSLib::KString;

# TODO: this only partially inits; there are some containerization issues with
# some attributes that will be handled at a later point

ok my $str = Bio::HTSLib::KString.new(), 'module loads';

done();
