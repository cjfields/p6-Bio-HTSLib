use v6;
use NativeCall;
use Bio::HTSLib::Library;

class Bio::HTSLib::KString is repr('CStruct');

has int $.l;
has int $.m;
has Str $.s;

