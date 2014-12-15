use v6;
use NativeCall;
use Bio::HTSLib::Library;

class Bio::HTSLib::BGZF is repr('CStruct');

#int errcode:16, is_write:2, is_be:2, compress_level:9, is_compressed:2, is_gzip:1;
has int $.errcode;
has int $.is_write; 
has int $.is_be;
has int $.compress_level;
has int $.is_compressed;
has int $.is_gzip;

#int cache_size;
has int $.cache_size;

#int block_length, block_offset;
has int $.block_length;
has int $.block_offset;

#int64_t block_address, uncompressed_address;
has int64 $.block_address;
has int64 $.uncompressed_address;

#void *uncompressed_block, *compressed_block;
has OpaquePointer $.uncompressed_block;
has OpaquePointer $.compressed_block;

#void *cache; // a pointer to a hash table
has OpaquePointer $.cache;

#struct hFILE *fp; // actual file handle
has OpaquePointer $.fp;

#struct bgzf_mtaux_t *mt; // only used for multi-threading
has OpaquePointer $.mt;

#bgzidx_t *idx;      // BGZF index
has OpaquePointer $.idx; # TODO, this will likely need to be defined

#int idx_build_otf;  // build index on the fly, set by bgzf_index_build_init()
has int $.idx_build_otf;

#z_stream *gz_stream;// for gzip-compressed files
has OpaquePointer $.gz_stream;

#define BGZF_BLOCK_SIZE     0xff00 // make sure compressBound(BGZF_BLOCK_SIZE) < BGZF_MAX_BLOCK_SIZE
our constant BGZF_BLOCK_SIZE = 0xff00;

#define BGZF_MAX_BLOCK_SIZE 0x10000

our constant BGZF_MAX_BLOCK_SIZE = 0x10000;

#define BGZF_ERR_ZLIB   1
our constant BGZF_ERR_ZLIB      = 1;

#define BGZF_ERR_HEADER 2
our constant BGZF_ERR_HEADER    = 2;

#define BGZF_ERR_IO     4
our constant BGZF_ERR_IO        = 4;

#define BGZF_ERR_MISUSE 8

our constant BGZF_ERR_MISUSE    = 8;

# TODO: not sure if this should be exposed. so commenting for now

#BGZF* bgzf_dopen(int fd, const char *mode);
#our sub bgzf_dopen(int, Str) returns Bio::HTSLib::BGZF is native($HTSLIB) is export { * }

#BGZF* bgzf_open(const char* path, const char *mode);
our sub bgzf_open(Str, Str) returns Bio::HTSLib::BGZF is native($HTSLIB) is export { * }

# TODO: define hFILE?  Seems to be opaque...
#BGZF* bgzf_hopen(struct hFILE *fp, const char *mode);
#our sub bgzf_hopen(OpaquePointer, Str) returns Bio::HTSLib::BGZF is native($HTSLIB) is export { * }

#int bgzf_close(BGZF *fp);
our sub bgzf_close(Bio::HTSLib::BGZF) returns int is native($HTSLIB) is export { * }

#ssize_t bgzf_read(BGZF *fp, void *data, size_t length);
our sub bgzf_read(Bio::HTSLib::BGZF, CArray[int], int) returns int is native($HTSLIB) is export { * }

#ssize_t bgzf_write(BGZF *fp, const void *data, size_t length);
our sub bgzf_write(Bio::HTSLib::BGZF, CArray[int], int) returns int is native($HTSLIB) is export { * }

#ssize_t bgzf_raw_read(BGZF *fp, void *data, size_t length);
our sub bgzf_raw_read(Bio::HTSLib::BGZF, CArray[int], int) returns int is native($HTSLIB) is export { * }

#ssize_t bgzf_raw_write(BGZF *fp, const void *data, size_t length);
our sub bgzf_raw_write(Bio::HTSLib::BGZF, CArray[int], int) returns int is native($HTSLIB) is export { * }

#int bgzf_flush(BGZF *fp);
our sub bgzf_flush(Bio::HTSLib::BGZF) returns int is native($HTSLIB) is export { * }

#int64_t bgzf_seek(BGZF *fp, int64_t pos, int whence);
our sub bgzf_seek(Bio::HTSLib::BGZF, int64, int) returns int64 is native($HTSLIB) is export { * }

##define bgzf_tell(fp) (((fp)->block_address << 16) | ((fp)->block_offset & 0xFFFF))
our sub bgzf_tell(Bio::HTSLib::BGZF) returns int is native($HTSLIB) is export { * }

#int bgzf_check_EOF(BGZF *fp);
our sub bgzf_check_EOF(Bio::HTSLib::BGZF) returns int is native($HTSLIB) is export { * }

#void bgzf_set_cache_size(BGZF *fp, int size);
our sub bgzf_set_cache_size(Bio::HTSLib::BGZF, int) is native($HTSLIB) is export { * }

#int bgzf_flush_try(BGZF *fp, ssize_t size);
our sub bgzf_flush_try(Bio::HTSLib::BGZF, int) returns int is native($HTSLIB) is export { * }

#int bgzf_getc(BGZF *fp);
our sub bgzf_getc(Bio::HTSLib::BGZF) returns int is native($HTSLIB) is export { * }

#int bgzf_getline(BGZF *fp, int delim, kstring_t *str);
our sub bgzf_getline(Bio::HTSLib::BGZF, int, OpaquePointer) returns int is native($HTSLIB) is export { * }

#int bgzf_read_block(BGZF *fp);
our sub bgzf_read_block(Bio::HTSLib::BGZF) returns int is native($HTSLIB) is export { * }

#int bgzf_mt(BGZF *fp, int n_threads, int n_sub_blks);
our sub bgzf_mt(Bio::HTSLib::BGZF, int, int) returns int is native($HTSLIB) is export { * }

#int bgzf_useek(BGZF *fp, long uoffset, int where);
our sub bgzf_useek(Bio::HTSLib::BGZF, int32, int) returns int is native($HTSLIB) is export { * }

#long bgzf_utell(BGZF *fp);
our sub bgzf_utell(Bio::HTSLib::BGZF) returns int32 is native($HTSLIB) is export { * }

#int bgzf_index_build_init(BGZF *fp);
our sub bgzf_index_build_init(Bio::HTSLib::BGZF) returns int is native($HTSLIB) is export { * }

#int bgzf_index_load(BGZF *fp, const char *bname, const char *suffix);
our sub bgzf_index_load(Bio::HTSLib::BGZF, Str, Str) returns int is native($HTSLIB) is export { * }

#int bgzf_index_dump(BGZF *fp, const char *bname, const char *suffix);
our sub bgzf_index_dump(Bio::HTSLib::BGZF, Str, Str) returns int is native($HTSLIB) is export { * }

submethod DESTROY() {
    bgzf_close(self)
}
