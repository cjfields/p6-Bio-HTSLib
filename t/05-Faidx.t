use v6;
use Test;
use lib './lib';
use lib './src/htslib';
use Bio::HTSLib::Faidx;

#ok my $lib = Bio::HTSLib::Faidx.new(), 'module loads and class works';

my $fasta = $*SPEC.catdir('t', 'data', 'multi.fna');
my $fasta-idx = $*SPEC.catdir('t', 'data', 'multi.fna.fai');

# create a fai index
#is(fai_build($fasta), 0, 'build index using exported sub');
#ok($fasta-idx.IO ~~ :e);

# load index
ok my $idx = Bio::HTSLib::Faidx.new($fasta), 'init fasta index';

# check sequences in the index
is($idx.num-seqs, 3, 'num-seqs');

# check by index position
for 0 .. $idx.num-seqs - 1 -> $index {
    ok($idx.seq-index($index), "seq-index: " ~ $idx.seq-index($index));
}

# These seqs are in the test file
my %has = 'gi|209211|gb|L08752.1|SYNPUC18V' => 2686,
          'gi|208958|gb|J01749.1|SYNPBR322' => 4361,
          'gi|9626372|ref|NC_001422.1|'     => 5386;

for %has.kv -> $seqid, $seqdata {
    ok($idx.has-seq($seqid), "has-seq: $seqid");
    is($idx.seq-length($seqid), $seqdata, "seq-length: $seqdata");
}

# but this isn't
nok($idx.has-seq('gi|6691170|gb|M77789.2|SYNPUC19V'), 'has-seq: negative check');

# get a sequence from the index
my $seq1 = $idx.fetch-seq('gi|209211|gb|L08752.1|SYNPUC18V');
is $seq1.chars, 2686, 'got sequence back';

# get a subsequence from the index (0-based inclusive)
my $seq2 = $idx.fetch-seq('gi|209211|gb|L08752.1|SYNPUC18V', :start(0), :end(99));
is $seq2.chars, 100, 'got subsequence back';

# get a sequence from the index using a region string (1-based)
my $seq3 = $idx.fetch('gi|209211|gb|L08752.1|SYNPUC18V');
is $seq3.chars, 2686, 'got sequence back';

my $seq4 = $idx.fetch('gi|209211|gb|L08752.1|SYNPUC18V:1-100');
is $seq4.chars, 100, 'got subsequence back';

is($seq1, $seq3, 'double check seqs match');

is($seq2, $seq4, 'double check seqs match');

#TODO: add check for bounds to seq-index

# delete the temp index file
if $fasta-idx.IO ~~ :e {
    unlink $fasta-idx;
}

done();
