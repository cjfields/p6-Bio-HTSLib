use v6;
use NativeCall;
use Bio::HTSLib::Library;

constant BGZF_BLOCK_SIZE     = 0xff00;
constant BGZF_MAX_BLOCK_SIZE = 0x10000;
constant BGZF_ERR_ZLIB       = 1;
constant BGZF_ERR_HEADER     = 2;
constant BGZF_ERR_IO         = 4;
constant BGZF_ERR_MISUSE     = 8;

class hFILE is repr('CPointer') { * }
class bgzf_mtaux_t is repr('CPointer') { * }
class kstring_t is repr('CPointer') { * }
class bgzidx_t is repr('CPointer') { * }
class BGZF is repr('CPointer') { * }

class Bio::HTSLib::BGZF {  # maybe use CStruct? struct BGZF

    #int errcode:16, is_write:2, is_be:2, compress_level:9, is_compressed:2, is_gzip:1;
    #has int32 $.errcode;
    #has int32 $.is_write; 
    #has int32 $.is_be;
    #has int32 $.compress_level;
    #has int32 $.is_compressed;
    #has int32 $.is_gzip;
    #
    ##int cache_size;
    #has int32 $.cache_size;
    #
    ##int block_length, block_offset;
    #has int32 $.block_length;
    #has int32 $.block_offset;
    #
    ##int64_t block_address, uncompressed_address;
    #has int64 $.block_address;
    #has int64 $.uncompressed_address;
    
    #void *uncompressed_block, *compressed_block;
    #has OpaquePointer $.uncompressed_block;
    #has OpaquePointer $.compressed_block;
    #
    ##void *cache; // a pointer to a hash table
    #has OpaquePointer $.cache;
    #
    ##struct hFILE *fp; // actual file handle
    #has OpaquePointer $.fp;
    #
    ##struct bgzf_mtaux_t *mt; // only used for multi-threading
    #has OpaquePointer $.mt;
    #
    ##bgzidx_t *idx;      // Bio::HTSLib::BGZF index
    #has OpaquePointer $.idx; # TODO, this will likely need to be defined
    #
    ##int idx_build_otf;  // build index on the fly, set by bgzf_index_build_init()
    #has int32 $.idx_build_otf;
    #
    ##z_stream *gz_stream;// for gzip-compressed files
    #has OpaquePointer $.gz_stream;
    
    # TODO: not sure if this should be exposed. so commenting for now
    #sub bgzf_dopen(int, Str) returns Bio::HTSLib::BGZF is native($HTSLIB) { * }
    
    sub bgzf_open(Str, Str) returns Bio::HTSLib::BGZF is native($HTSLIB) { * }
    
    # TODO: not sure if this should be exposed. so commenting for now
    #sub bgzf_hopen(OpaquePointer, Str) returns Bio::HTSLib::BGZF is native($HTSLIB) { * }
    
    sub bgzf_close(Bio::HTSLib::BGZF) returns int is native($HTSLIB) { * }
    
    sub bgzf_read(Bio::HTSLib::BGZF, CArray[int], int) returns int is native($HTSLIB) { * }
    
    sub bgzf_write(Bio::HTSLib::BGZF, CArray[int], int) returns int is native($HTSLIB) { * }
    
    sub bgzf_raw_read(Bio::HTSLib::BGZF, CArray[int], int) returns int is native($HTSLIB) { * }
    
    sub bgzf_raw_write(Bio::HTSLib::BGZF, CArray[int], int) returns int is native($HTSLIB) { * }
    
    sub bgzf_flush(Bio::HTSLib::BGZF) returns int is native($HTSLIB) { * }
    
    sub bgzf_seek(Bio::HTSLib::BGZF, int64, int) returns int64 is native($HTSLIB) { * }
    
    sub bgzf_tell(Bio::HTSLib::BGZF) returns int is native($HTSLIB) { * }
    
    sub bgzf_check_EOF(Bio::HTSLib::BGZF) returns int is native($HTSLIB) { * }

    sub bgzf_is_bgzf(Str) returns int is native($HTSLIB) { * }
    
    sub bgzf_set_cache_size(Bio::HTSLib::BGZF, int) is native($HTSLIB) { * }
    
    sub bgzf_flush_try(Bio::HTSLib::BGZF, int) returns int is native($HTSLIB) { * }
    
    sub bgzf_getc(Bio::HTSLib::BGZF) returns int is native($HTSLIB) { * }
    
    sub bgzf_getline(Bio::HTSLib::BGZF, int, OpaquePointer) returns int is native($HTSLIB) { * }
    
    sub bgzf_read_block(Bio::HTSLib::BGZF) returns int is native($HTSLIB) { * }
    
    sub bgzf_mt(Bio::HTSLib::BGZF, int, int) returns int is native($HTSLIB) { * }
    
    sub bgzf_useek(Bio::HTSLib::BGZF, int32, int) returns int is native($HTSLIB) { * }
    
    sub bgzf_utell(Bio::HTSLib::BGZF) returns int32 is native($HTSLIB) { * }
    
    sub bgzf_index_build_init(Bio::HTSLib::BGZF) returns int is native($HTSLIB) { * }
    
    sub bgzf_index_load(Bio::HTSLib::BGZF, Str, Str) returns int is native($HTSLIB) { * }
    
    sub bgzf_index_dump(Bio::HTSLib::BGZF, Str, Str) returns int is native($HTSLIB) { * }
    
    #multi method new() { }
    #
    #method new( $file ) {
    #    if bgzf_open
    #}

    multi method new($file)    {
        bgzf_open($file, 'r3');
    }
    
    multi method new($file, $mode)    {
        bgzf_open($file, $mode);
    }
    
    method read($length) {
        my Str $data;
        bgzf_read(self, $data, $length);
        return ($data, $length);
    }

    method write(Str $data, $length?) {
        bgzf_write(self, $data, $length);
    }
    
    method raw-read($length) {
        my Str $data;
        bgzf_raw_read(self, $data, $length);
        return ($data, $length);
    }
    
    method raw-write(Str $data, $length) {
        bgzf_raw_write(self, $data, $length);
    }
    
    method flush {
        bgzf_flush(self)
    }
    
    method seek($pos, $whence) {
        bgzf_seek(self, $pos, $whence)
    }
    
    method tell {
        bgzf_tell(self)
    }
    
    method check-eof {
        bgzf_check_EOF(self)
    }
    
    method is-bgzf($file) {
        bgzf_is_bgzf($file);
    }
    
    #method set-cache-size($size) {
    #    bgzf_set_cache_size(self, $size)
    #}
    #
    #method flush-try($size) {
    #    bgzf_flush_try(self, $size)
    #}
    #
    #method getc {
    #    bgzf_getc(self)
    #}
    #
    #method getline($delim) {
    #    my kstring_t $str;
    #    bgzf_getline(self, $delim, $str);
    #}
    #
    #method read-block {
    #    bgzf_read_block(self)
    #}
    #
    #method mt($threads, $n_sub_blocks) {
    #    bgzf_mt(self, $threads, $n_sub_blocks);
    #}
    #
    #method useek($offset, $where) {
    #    bgzf_useek(self, $offset, $where)
    #}
    #
    #method utell {
    #    bgzf_utell(self)
    #}
    #
    #method index-build-init {
    #    bgzf_index_build_init(self)
    #}
    #
    #method index-load(Str $bname, Str $suffix?) {
    #    bgzf_index_load(self, $bname, $suffix);
    #}
    #
    #method index-dump(Str $bname, Str $suffix?) {
    #    bgzf_index_dump(self, $bname, $suffix);
    #}
    #
    #submethod DESTROY() {
    #    bgzf_close(self.bgzf)
    #}

}