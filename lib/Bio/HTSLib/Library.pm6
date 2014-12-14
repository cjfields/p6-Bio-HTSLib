use v6;

module Bio::HTSLib::Library;

use LibraryMake;

BEGIN {
    our sub library {
        my $so = get-vars('')<SO>;
        for @*INC {
            note $_;
            if ($_~'/libhts'~$so).IO ~~ :f {
                return $_~'/libhts'~$so;
            }
        }
        die "Unable to find libhts"~$so;
    }
    
    our $LIBRARY = library()
}