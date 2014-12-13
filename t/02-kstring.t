use v6;
use Test;
use lib 'blib/lib';
use Bio::HTSLib::KString;

ok my $str = Bio::HTSLib::KString.new(), 'module loads';
is $str.l, 0, 'init works';
is $str.m, 0, 'init works';
nok $str.s, 'init works';

$str = Bio::HTSLib::KString.new(l   => 1, m => 12, s => 'Foo');
is $str.l, 1, 'init works';
is $str.m, 12, 'init works';
$str.s = 'foo';
is $str.s, 'foo', 'init works';

done();