use v6;
use NativeCall;
use LibraryMake;

# Find our compiled library.
# It was installed along with this .pm6 file, so it should be somewhere in
# @*INC
sub library {
    my $so = get-vars('')<SO>;
    for @*INC {
        if ($_~'/libhts'~$so).IO ~~ :f {
            return $_~'/libhts'~$so;
        }
    }
    die "Unable to find libhts"~$so;
}

class Bio::HTSLib {
    
    method install-library {
        return library();
    }
    
}
