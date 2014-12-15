use v6;
use NativeCall;
use Bio::HTSLib::Library;
use Compress::Zlib::Raw;

class Bio::HTSLib::KStream is repr('CPointer');

sub ks_init() returns Bio::HTSLib::KStream is native($HTSLIB) { * }
sub ks_destroy(Bio::HTSLib::KStream) is native($HTSLIB) { * }

#multi method BUILD() { ks_init() }
submethod DESTROY() { ks_destroy(self) }

