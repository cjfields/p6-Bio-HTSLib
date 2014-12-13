use v6;
use NativeCall;

class Bio::HTSLib::KString is repr('CStruct');

use Bio::HTSLib::Library;

has int $.l;
has int $.m;
has Str $.s;

# static inline int ks_resize(kstring_t *s, size_t size)

my sub ks_resize(Bio::HTSLib::KString $s, int $size) returns int32 is native('libhts') { * }

# static inline char *ks_str(kstring_t *s)

my sub ks_str(Bio::HTSLib::KString $s) returns Str is native('libhts') { * }

# static inline size_t ks_len(kstring_t *s)

my sub ks_len(Bio::HTSLib::KString $s) returns int is native('libhts') { * }

# static inline char *ks_release(kstring_t *s)

my sub ks_release(Bio::HTSLib::KString $s) returns Str is native('libhts') { * }

# static inline int kputsn(const char *p, int l, kstring_t *s)

my sub kputsn(Str $p, int32 $l, Bio::HTSLib::KString $s) returns int32 is native('libhts') { * }

# static inline int kputs(const char *p, kstring_t *s)

my sub kputs(Str $p, Bio::HTSLib::KString $s) returns int32 is native('libhts') { * }

# static inline int kputc(int c, kstring_t *s)

my sub kputc(int32 $c, Bio::HTSLib::KString $s) returns int32 is native('libhts') { * }

# static inline int kputw(int c, kstring_t *s)

my sub kputw(int32 $c, Bio::HTSLib::KString $s) returns int32 is native('libhts') { * }

# static inline int kputuw(unsigned c, kstring_t *s)

my sub kputuw(int16 $c, Bio::HTSLib::KString $s) returns int32 is native('libhts') { * }

# static inline int kputl(long c, kstring_t *s)

my sub kputl(int $c, Bio::HTSLib::KString $s) returns int32 is native('libhts') { * }

# static inline int *ksplit(kstring_t *s, int delimiter, int *n)

my sub ksplit(Bio::HTSLib::KString $s, int32 $delimiter, CArray[int32] $n) returns int32 is native('libhts') { * }

submethod BUILD(int :$l = 0, int :$m = 0, Str :$s = Nil) {
    note("In BUILD");
    $!l := $a;
    $!m := $m;
    $!s := $s;
}

submethod DESTROY() {
    ks_release(self)
}
