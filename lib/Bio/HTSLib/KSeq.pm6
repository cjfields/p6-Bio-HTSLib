use v6;
use NativeCall;

#typedef struct {							\
#	kstring_t name, comment, seq, qual;		\
#	int last_char;							\
#	kstream_t *f;							\
#} kseq_t;

class Bio::HTSLib::KSeq is repr('CStruct');

## these are all technically Str, so maybe simplify this?
#has Bio::HTSLib::KString $.name;
#has Bio::HTSLib::KString $.comment;
#has Bio::HTSLib::KString $.seq;
#has Bio::HTSLib::KString $.qual;
#has int32 $.last_char;
#has Bio::HTSLib::KStream $.f;
