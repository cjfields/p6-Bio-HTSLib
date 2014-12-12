use v6;
use LibraryMake;

my $dir = './src/lib';
my %vars = get-vars($dir);
process-makefile('./src', %vars);
make("./src", $dir);