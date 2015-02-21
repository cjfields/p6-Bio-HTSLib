use v6;

use NativeCall;

use Bio::HTSLib::Library;

class Bio::HTSLib::Faidx is repr('CPointer');

our sub fai_build(Str) returns int32 is native($HTSLIB) is export { * }

our sub fai_destroy(Bio::HTSLib::Faidx) is native($HTSLIB) is export  { * }

our sub fai_load(Str) returns Bio::HTSLib::Faidx is native($HTSLIB) is export  { * }

#### char *fai_fetch(const faidx_t *fai, const char *reg, int *len);

our sub fai_fetch(Bio::HTSLib::Faidx, Str, CArray[int32]) returns Str is native($HTSLIB) is export  { * }

#### char *faidx_fetch_seq(const faidx_t *fai, const char *c_name, int p_beg_i, int p_end_i, int *len);

our sub faidx_fetch_seq(Bio::HTSLib::Faidx, Str, int32, int32, CArray[int32]) returns Str is native($HTSLIB) is export  { * }

our sub faidx_has_seq(Bio::HTSLib::Faidx, Str) returns int is native($HTSLIB) { * }

our sub faidx_nseq(Bio::HTSLib::Faidx) returns int32 is native($HTSLIB) { * }

our sub faidx_iseq(Bio::HTSLib::Faidx, int) returns Str is native($HTSLIB) { * }

our sub faidx_seq_len(Bio::HTSLib::Faidx, Str) returns int32 is native($HTSLIB) is export { * }


method new(Str $file) {
    if ($file ~ '.fai').IO ~~ :e {
        fai_load($file);
    } else {
        # TODO: should this be explicit?
        fai_build($file);
    }
}

method num-seqs {
    faidx_nseq(self)
}

method has-seq(Str $seqid) returns Bool {
    ?faidx_has_seq(self, $seqid)
}

method seq-index(Int $index) returns Str {
    ~faidx_iseq(self, $index)
}

method seq-length(Str $seqid) returns Int {
    faidx_seq_len(self, $seqid)
}

method fetch-seq(Str $seqid, :$start = 0, :$end? is copy) returns Str {
    my $len = faidx_seq_len(self, $seqid);
    $end //= $len;
    # TODO: a little funky, to pass in a pointer we use a typed CArray here.
    my $retlen := CArray[int32].new();
    my Str $seq = faidx_fetch_seq(self, $seqid, $start, $end, $retlen);
    # TODO: check $retlen for problems
    return $seq;
}

method fetch(Str $region) returns Str {
    my $retlen := CArray[int32].new();
    my Str $seq = fai_fetch(self, $region, $retlen);
    # TODO: check $retlen for problems
    return $seq;
}


# TODO: this should be run during GC
method DESTROY {
    fai_destroy(self)
}
